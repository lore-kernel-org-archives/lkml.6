Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0585CC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F9E24473
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUt3uhcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F9E24473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933652AbeFVPNk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:13:40 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:52023 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933606AbeFVPNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:13:34 -0400
Received: by mail-wm0-f45.google.com with SMTP id r15-v6so2598607wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 08:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lYOfYLLq5xp7yD+iW4SG+jZNiGxVWxmtMC2LAko9y7Q=;
        b=MUt3uhcg/si7xlquGqnW/mQjTVj2suq6A9Ye9ap+mQzL3fYtFnf1y9b/mC+hdkp8FW
         KI2rXCIJaLK2xn/Q7eSUi1nN49/VGVqnWHMnyM4gPJ01rs+ZUxs+liQBu1Zz9bpRJ/lu
         I12427ZgQ+9f0DQCZNuwe7pMb1FRWLVkvqS+PqRtpJlsZ6KrrWFIw7czG9Sjf28mCnOy
         kMYQHu/cBY6havt5x7y5GHu5J0PUUQ5qK9iIZAsd5c2MIPhs6SPVvySYN4VCH1X2yaAN
         ft4xRDc9JVil+T7CZyhre0UU5Kx+B4CQ8GXJL/KZ83vLHF/nQ1Oe5eA5KOI6bN2B9H3G
         Lo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lYOfYLLq5xp7yD+iW4SG+jZNiGxVWxmtMC2LAko9y7Q=;
        b=STps6Qn68A9yf9tojqLbk1cdTrRon/HexMWknd2lQnaz5DOAcKn6WVgCkE0IPGy6wz
         vAGV3uZGobOXa0PAchUHfMWU2ynnHVguHT3iq9EKualeju7CZgufWOVXEdayY3i/oQQl
         Gd7DYZbyzjz3z2+sB2RYA7xNeBAYfBWgaN9/VDBiaJxXI5HP5j/bZS9ncj+YWe0mXzLT
         c0Fa0Rmibm922HkcsO2QCw9e6yiDVyEMQEuK5bd4LPU5CVL0Ic8VwPwmXaLlcRinGmiM
         M7Akd0YARquhXRqawkTMiuJOiZaoMIkIJpjZS9w2821y+Da/P8zpWuGh9hKf41pNf4TM
         g4hA==
X-Gm-Message-State: APt69E0hjmflEYVUUsgkYlO/VHj1hwi8nwvjCDgCc564I31g8VAFv3Jg
        MBXYItxkRDqJDZ9FkirisYM=
X-Google-Smtp-Source: ADUXVKKDImlvGXinosiQgbOWdxAEuBos/Y59sQTHdtDvkDXeJmZVgcqiZBaN3mYiYxDLhisS9o474w==
X-Received: by 2002:a1c:8b52:: with SMTP id n79-v6mr2009583wmd.148.1529680412672;
        Fri, 22 Jun 2018 08:13:32 -0700 (PDT)
Received: from localhost ([165.165.77.132])
        by smtp.gmail.com with ESMTPSA id b16-v6sm12553494wrm.15.2018.06.22.08.13.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 08:13:32 -0700 (PDT)
Date:   Fri, 22 Jun 2018 17:12:03 +0200
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
Message-ID: <20180622151203.GA23248@kerdev>
References: <1529514635-17948-1-git-send-email-eklikeroomys@gmail.com>
 <20180620200829.qm2zxeyyl5kqh6gu@mwanda>
 <20180621044252.GA19583@kerdev>
 <20180621082225.xuhqvm7bevbiuaso@mwanda>
 <20180621155352.GA20712@kerdev>
 <20180622104654.2snozuvc7sc6tk76@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622104654.2snozuvc7sc6tk76@mwanda>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, in that case I will fix and resend the patch.

Kind Regards,
Chris Opperman
