Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63150C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1157F2148E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jb6s0Sjl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1157F2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbeHVSwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 14:52:41 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:34212 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbeHVSwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 14:52:41 -0400
Received: by mail-yb0-f196.google.com with SMTP id t10-v6so819432ybb.1;
        Wed, 22 Aug 2018 08:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TwJOS621+XznctelMUF5GPzcOweEAio+pwKs3NRs1+0=;
        b=jb6s0SjludOT2j6Z5HgjTfYvrsd9e7YfApu/eOjQt9SpiFSsa5hXoYK+HGdtccyo5t
         TJ4lkvduYyrprRTAUYmoNcNXPOfu/q7hPaIUqH0TeaNROvxHpuObwGob6mxTwlaFf9nr
         sqTwH3hqky+fVUx/X5NJE1CFOK8JLU4QOzZZijbepo78yVruOI9WjYdqt5f2Yy82HpCE
         aPIwyhH8W8hom6kjz203NvUlA/l48M0OW6daNFE0LPyrCDuavWiQcu+mo8m6HCIvE/KL
         X+7qSg9NYCvQOxzStKHDnHv4aT2AMSgXV5DAFbkfStd30chIjg6F7t5Bts9ieQz/vP0C
         Hrxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TwJOS621+XznctelMUF5GPzcOweEAio+pwKs3NRs1+0=;
        b=Z+RAGssRIBJ6rnJHyl0vbMplF0+1tjXZsUjoStCT0Mlllz+TQZd5Bdq+ZMgARLvvFe
         36sKtbFw0UcgAcA4SgF3z6uAT9kZcL3iHRlyGna6RKv4f9QGqihq6EuULj033QrOGMbM
         ezwsIDv/YcjL3nM4p4OzslIaO1SPfFDk3qvm9hj1IKx8TSg6Az/wkvia+plgA47Vc+D6
         9QwTLicEXd55FSwS54ClqHwmUwuu5Lth++SpuSgpIZ13ehfPQACnTHXY6Cz8iizyxsP0
         ayTZ/ysUu5aOOs/ox2FP+Zce5PT5S0/9/B+2mxe2U3iqTIupgj04ohsQgvy2EDB3RUZ6
         YKzw==
X-Gm-Message-State: AOUpUlHWpJKumIPstc00UNVk1GEW4I/vXg2jrCXzUJaouleqyYaPlW1b
        qEp6Xgj9qr09o0DFDiLO/E8=
X-Google-Smtp-Source: AA+uWPxZe0icYgjYZYGY6in/S0P9VL1o2CjdRI/VlgpOom/mdlrAGyFTRzzFfl73VUBPeMAJ96FXXQ==
X-Received: by 2002:a25:da96:: with SMTP id n144-v6mr10440298ybf.398.1534951640311;
        Wed, 22 Aug 2018 08:27:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1dc9])
        by smtp.gmail.com with ESMTPSA id c69-v6sm1792080ywb.11.2018.08.22.08.27.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 08:27:19 -0700 (PDT)
Date:   Wed, 22 Aug 2018 08:27:17 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] ata: ahci-platform: add reset control support
 except for existing drivers
Message-ID: <20180822152717.GU3978217@devbig004.ftw2.facebook.com>
References: <1534939983-16264-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534939983-16264-1-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 09:13:00PM +0900, Kunihiko Hayashi wrote:
> Add support to get and control a list of resets for the device, and
> add the flag indicating whether to use the reset. Existing SoC-dependent
> drivers set 0 to this flag.

Applied to libata/for-4.19.

Thanks.

-- 
tejun
