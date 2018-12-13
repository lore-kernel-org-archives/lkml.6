Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD168C67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B0520879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544708100;
	bh=N3DzLAP9uMfsYhmgC5dCRSElV0sBMQUNSsoMpZcESZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LOFp6rXLBTEWXimQ03cXOkbA+dqF5WGK1p4snIpS4Uh+aYlHOtzsWW0WySR0BTG86
	 hvEe9OaijNWN+AQeOLNomGBnngdf63dMpq7GWwFPZbGmilfiiGAouZ6ebthHqlsObB
	 7F07UIGWo0ZVs63X/qpxIOWRTXiok7XryQzhR4BY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B0520879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbeLMNe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:34:59 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45174 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729281AbeLMNe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:34:56 -0500
Received: by mail-lf1-f67.google.com with SMTP id b20so1553477lfa.12;
        Thu, 13 Dec 2018 05:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EKYF2RDxK2eIgZbX3RBSwXqebS9A75QUuybBhj2lclw=;
        b=ocQlv9/humR1ptq7sDk9Zy8A4k+gquZLmSC/b9b6HNmS6gSl4FPnCypYbyebhZTWcR
         E21ksEt8K6n0VEYW/iGVSYpYygU1wJrEdoketZeXIOLezKGP3+BX9SXz642sMRXdHl/f
         HAl0zIIMtV8Nl0XzdkU/3w6HW3rmm3L7uBH9Tvzy94cdCgU0BRxZfqmAWPRtRn6Mz5Dg
         rX/dxbqrEHO15JMO4vwb/xb0GSR2wjGWlWXYbUBQ0T9CEVRjo+aJ3DnC6MluZINIW1lN
         zDKMP5/DriCHMp6Da+bi0snExQiN0+Gwq9Zz5G9f3+morcerrCPImBWEOkHF0ouIP8lL
         XfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EKYF2RDxK2eIgZbX3RBSwXqebS9A75QUuybBhj2lclw=;
        b=TGodhAhLJ8nVDGYTzC/qrr/88y6ZedvSeZKOSzjmzwt8ZrQUgcdZhhJZXTROAbJcpN
         555+3Iw7Zo8ZsXJjo1HvPhnHuVcKgzDSaHslyo4Loh9r8tP0FRbr1VHLak6JaHuECpoT
         vHWv5Qt+JuXoTm/jjhq1vp3qJyVBvAPNEI3HKt/fEIlCdNwKQMQCo21gGSTlkuU7Fn5W
         e3lMvsEEqD2RgLduC7SO9dVqB4zGWRXIY+b9BLJ9m/fc4HoxmDqWIoH/QW6nlIHveemu
         r7HiJdamP5TP2YkQwu5Y1bGeom+qNvkBNRDt3id0lWkJw0sLwHA7LF0DJLrJc0e2lo3f
         rhpA==
X-Gm-Message-State: AA+aEWY64tZ9LdC5Bx40A7NE82mLqMX0X7e5P+cI5S+tzweka22Dn8wj
        Llcf6UWuWU5Y8vpGpLCGDDF5SR8J
X-Google-Smtp-Source: AFSGD/X1qgkEHx05ePjxZ0nsG3F4W4mvd9If2tB78JDKM39/xiVOb2+guJnAegzztoBfhU241dbN3A==
X-Received: by 2002:a19:9b50:: with SMTP id d77mr14623187lfe.137.1544708094325;
        Thu, 13 Dec 2018 05:34:54 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id r10-v6sm307038ljj.71.2018.12.13.05.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 05:34:53 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gXR8l-0000pR-9k; Thu, 13 Dec 2018 14:34:59 +0100
Date:   Thu, 13 Dec 2018 14:34:59 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gnss: sirf: fix activation retry handling
Message-ID: <20181213133459.GO3500@localhost>
References: <20181205102149.21167-1-johan@kernel.org>
 <20181209205802.081b64f2@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209205802.081b64f2@aktux>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 08:58:02PM +0100, Andreas Kemnade wrote:
> Hi,
> 
> On Wed,  5 Dec 2018 11:21:49 +0100
> Johan Hovold <johan@kernel.org> wrote:
> 
> > Fix activation helper which would return -ETIMEDOUT even if the last
> > retry attempt was successful.
> > 
> > Also change the semantics of the retries variable so that it actually
> > holds the number of retries (rather than tries).

> Sounds sane. I rebased my patch series on top of it and improved my
> testing script (the manual on/off toggle in between was not working
> properly)

That's great. And thanks for testing. I'm a bit short on time at the
moment, but will try to take at least a quick look at your v2 today.

Johan
