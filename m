Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A133EC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 04:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B16208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 04:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gY6zE3ff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B16208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750991AbeFUEo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 00:44:26 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38801 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750789AbeFUEoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 00:44:24 -0400
Received: by mail-wm0-f42.google.com with SMTP id 69-v6so3235363wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 21:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KKo+u+m+Y+uqc6SH92cvLHrLIuIF014bxPhzQ0q+dfE=;
        b=gY6zE3ffsBzak9Qk+EmE0X+Gj31x6QUSsgK55YWCBBOsMJenY4qUOY6tAvzzVt7WW+
         BaoceNY6avUpg9HLo5DraXS8bt5y+VjNXYOG4fTQ8PH5DIaJ30Y1xz71F0Bax2Ww3X4T
         lE/EZU++HpzY0MBncRp5hKWl19cgxWAA3milelniy6H9NxkgRSvU30Xp9aJSAiEMSL63
         zJx5dM2fP88j7Pq2cEYfRKXj5XU9sJ5UDf4bA87h8+ZAkNesfCz7wp0Y01rL1miSNB68
         AQnWFpLPRi+3IBqC0uqOBDlypYdyDlixqhZ+yZ27+OsYg25QA9SSvfK9BoBVpCtkAuNC
         IHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KKo+u+m+Y+uqc6SH92cvLHrLIuIF014bxPhzQ0q+dfE=;
        b=BvW4l5E63+s/wyLD5QvBUe1xkSd/JI+qLsu+V5DY4CJTUZ15qnEl0hWvHmUtSdYUsV
         ApPio71bCkCN4/1Wk1ufnbUEBDMkDVwi41dNOlutTdN8pCwxsFxf5sSAJMxdmELgYBm/
         J/iPdNqUtDVdM+6gfMNmlDG9U9LgPMrPSH+7TABrfTQnCPgQ7asGkn8V9g30p8LXPMii
         3pIg2wtSejsfKmn90ImzP0NQVoUAtz4LU3QjU3xT8ejFIyLriEUFo6bK27SbcCVkaHBb
         A4Ext73Q6zht75bkoYUi1sHB3VzNVuJdrpxhCrqKRLbmMNK+sG4KF2oT0AqCVc1o+v42
         /EzQ==
X-Gm-Message-State: APt69E03yBearkcCcq32J6Dff3iTHwAG6+52iIB1tkBqBmiv17LO/Ec2
        cTrMf8bcQcX6X4ucQY5IJgE=
X-Google-Smtp-Source: ADUXVKJSeF9y0DddjaDBy2P2IALvydULtdq28vb0c3jCHbD1nXLf+PZqyn6IffwP+oHUgCHidileSw==
X-Received: by 2002:a1c:7192:: with SMTP id d18-v6mr3565734wmi.115.1529556263586;
        Wed, 20 Jun 2018 21:44:23 -0700 (PDT)
Received: from localhost (8ta-151-217-222.telkomadsl.co.za. [41.151.217.222])
        by smtp.gmail.com with ESMTPSA id y3-v6sm4001686wro.21.2018.06.20.21.44.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 21:44:23 -0700 (PDT)
Date:   Thu, 21 Jun 2018 06:42:52 +0200
From:   Chris Opperman <eklikeroomys@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Kate Stewart <kstewart@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] staging: wlan-ng: improved readability of function
 prism2_add_key
Message-ID: <20180621044252.GA19583@kerdev>
References: <1529514635-17948-1-git-send-email-eklikeroomys@gmail.com>
 <20180620200829.qm2zxeyyl5kqh6gu@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620200829.qm2zxeyyl5kqh6gu@mwanda>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

I agree completely. I was concerned whether the preprocessor definitions in
p80211metadef.h were named according to some convention as there are
many definitions named similarly there. 

I am considering renaming this specific definition to "p80211_dot11_keyid", 
would that be more acceptable?

Kind Regards,
Chris Opperman
