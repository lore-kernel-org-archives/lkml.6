Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F0BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58F820652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBLZH93G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfARNQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:16:18 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43052 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfARNQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:16:18 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so6352452plb.10;
        Fri, 18 Jan 2019 05:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D8DC5RbBkTd9slWSnPIMkEp2BPDFyQpE9Fz08jeK+UM=;
        b=cBLZH93GeHksHcjlcZFmJ8sOugHEFH6BasuUHZK0HX3aAg4CcxGld6mLDmRqfiy2gu
         OOSstNe3VzLGiBXMQqCgd7ZO1ZM532NsAEyW5XLletOUEtJE2/JfoEI955imxXbRn6rq
         B9oY+t+BSD3NPdhDnPviWOktIpMeyw/Jfi6k8KS7r0mAtH9Tetzfg5t73qHwfA9c0FS6
         rMMOpnDxoqVQ+udz8klMd7rRly8aMPpW0XK4fzuXbXxnBlBdECyM486NqczWJzq1DH9L
         S+zNI7gpnvPA1anOUTARoTG6jCimNwot0nuVCW4hfn+bIgsrifjCmQ0g3cak1BmX9GuM
         XmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D8DC5RbBkTd9slWSnPIMkEp2BPDFyQpE9Fz08jeK+UM=;
        b=cP1hTrJEoQxHDl2nT6LTRhQFKnLm4lj5fZ2nbNkjcq1I+6eSCqGM/TH6VzzIDeLL3i
         gAwU3+a7naZ/jBQ4Zlv/GK3mXb+8uCk36LG8ouohan5zSoWgikAYZ6sRKKF5f4ip/JLf
         dpTohx7nbV2HmcH8heodEDWSlCnnwA3Ka8/2K/+vYZUy/PS25InxeV9xTQV5Xh4qcXfe
         rM46v+y+XKnO68pRzI3PQNu7mS8CpjAh0qJtfpoBVc1WbGAyz20cigLnZNOyVqO3wx6l
         1UyRWKfhz9BFEaMNcZJVaQQigRN7EhJ5qfDYpT5uqsIZtH8/WfTqgQKlpsQBYdxi2hmk
         DFoA==
X-Gm-Message-State: AJcUukcKUVyvXE8gR18TSBCu9c+xxI7GZYG2HpJT6XzW7+ELskCkcETx
        NhXQ8m+gEkdyFZsFoYG2IiQ=
X-Google-Smtp-Source: ALg8bN7nJvBeV7vlXrc8IGty4+qyGlQBqWNngx0WZJ/SHOeehA27rEqy28UVSO3fxEBfcSVQ5CUJtA==
X-Received: by 2002:a17:902:34a:: with SMTP id 68mr19472350pld.268.1547817376943;
        Fri, 18 Jan 2019 05:16:16 -0800 (PST)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id d11sm8866196pgi.25.2019.01.18.05.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 05:16:16 -0800 (PST)
Date:   Sat, 19 Jan 2019 00:16:11 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCHv4 00/13] Heterogeneuos memory node attributes
Message-ID: <20190118131611.GG26056@350D>
References: <20190116175804.30196-1-keith.busch@intel.com>
 <20190117125821.GF26056@350D>
 <20190117154436.GB31543@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117154436.GB31543@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 08:44:37AM -0700, Keith Busch wrote:
> On Thu, Jan 17, 2019 at 11:58:21PM +1100, Balbir Singh wrote:
> > On Wed, Jan 16, 2019 at 10:57:51AM -0700, Keith Busch wrote:
> > > It had previously been difficult to describe these setups as memory
> > > rangers were generally lumped into the NUMA node of the CPUs. New
> > > platform attributes have been created and in use today that describe
> > > the more complex memory hierarchies that can be created.
> > > 
> > 
> > Could you please expand on this text -- how are these attributes
> > exposed/consumed by both the kernel and user space?
> > 
> > > This series' objective is to provide the attributes from such systems
> > > that are useful for applications to know about, and readily usable with
> > > existing tools and libraries.
> > 
> > I presume these tools and libraries are numactl and mbind()?
> 
> Yes, and numactl is used the examples provided in both changelogs and
> documentation in this series. Do you want to see those in the cover
> letter as well?

Not really, I was just reading through the cover letter and was curious

Balbir Singh.
