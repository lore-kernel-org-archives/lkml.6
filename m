Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B407C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C307B21759
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrVX24Id"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C307B21759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753958AbeGCFIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 01:08:37 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:45083 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753718AbeGCFIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 01:08:36 -0400
Received: by mail-qk0-f174.google.com with SMTP id c192-v6so342439qkg.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 22:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BfZXobEAWf8XZFQ2NJsYiaEKyPjE1EIM1LsUYaSpLos=;
        b=jrVX24Id8loIGE3tdPkf3Q5g91ZMSaWjtEYhHWLgZNgZpqrLZKul0dKO5ALnUn6qcw
         nNiHbI11gXosEfGFDsF8l2qxx2I2KNy1IsNInTgJeAiQ8YokB0FgUt/aFRkeSXleQxx9
         7N931J1xyhlZQm6YC5O8rTgryDy+gOUOFHA7Y/kN5hQK3p4BJPgGNwpD/K91dfQdI1cB
         lbSJtC/jSkV5D7AzC+/ppBimojhfhLxt6UuWWjWajrPOOtktSqxMKa1TUYwwu0SFnH7q
         EpR0BUAi/jQD/kiGRg51FB8ZA3xej+bWsY4JfsefKRetPikLpONpD9MC+mmUK+gUxYTc
         oCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BfZXobEAWf8XZFQ2NJsYiaEKyPjE1EIM1LsUYaSpLos=;
        b=hTS48Ey5Dmmu3z1+/UsHKhbDWmzCzV2ms5B0YON9NbSVdsli2EEyN4Kl0mfMd7ErLv
         IjJrv4mfNNuixJfQe8ABxj4GWY/uZrWbzDrb8/vHJv1IdLXZUJ1dr0WUT8CkqFDLypx6
         8ra/uTreS4cfLHDFyYhM6+wOhTiXC6rQpK1QsRLTJyoqo2HxAGWLZ8H4379aO+rtZa+h
         wctLzfjJGZ9lTaMhRiVegPefDF5BVOe9r3kBHuSknjyAMXbBtOEZbS7oRCuX7AQFhXaj
         OIJbMtFlnvBcqP3vVcASvx+01k6JhFNPP684nuLSq5TswIDZm0mI5MtOj2kJDcunsQGo
         Zb8A==
X-Gm-Message-State: APt69E0sSeOdhs3M5w8EbPlAw9hf8/PwGfGK4EtTOGr7mp6bAIpdBMzh
        Xz8hUDoRzb3OGE2JTg4Bd4tDImTsIVw=
X-Google-Smtp-Source: AAOMgpdnNEBQSgOd85srXEG+GO0R6P4m1zBbI6BZQGgr2ZImDYI1JEEMSFb8jIS5Gxe2/SJQAc+Pzg==
X-Received: by 2002:a37:cf50:: with SMTP id e77-v6mr24508191qkj.74.1530594515491;
        Mon, 02 Jul 2018 22:08:35 -0700 (PDT)
Received: from peter-ThinkPad-X220-Tablet (d-74-214-40-72.cpe.metrocast.net. [74.214.40.72])
        by smtp.gmail.com with ESMTPSA id t41-v6sm178925qte.86.2018.07.02.22.08.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 22:08:34 -0700 (PDT)
Date:   Tue, 3 Jul 2018 01:08:33 -0400
From:   Peter Vernia <peter.vernia@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Christian =?iso-8859-1?Q?L=FCtke-Stetzkamp?= <christian@lkamp.de>,
        John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH] staging: mt7621-pinctrl: Replaces "unsigned" with
 "unsigned int", fixes mixed indentation, and puts spaces after commas.
Message-ID: <20180703050833.GA6281@peter-ThinkPad-X220-Tablet>
References: <1530379055-6713-1-git-send-email-peter.vernia@gmail.com>
 <20180630193245.qtowzg7cecjk27ek@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180630193245.qtowzg7cecjk27ek@mwanda>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 
> The subject is over 72 characters or whatever the limit is and there
> isn't a commit message.

Dan, thanks for your help, I realize where I went wrong now. I will re-submit
the patch fresh to fix the message subject.

--Peter 
