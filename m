Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF31C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1816F208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlcW5ESS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1816F208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbeGKKI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:08:27 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34552 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeGKKI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:08:26 -0400
Received: by mail-pl0-f67.google.com with SMTP id z9-v6so8943653plo.1;
        Wed, 11 Jul 2018 03:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=imuLUt+k8VCUVCb+R1LYWvu/bASMK/g1Jkrz98iL/pQ=;
        b=GlcW5ESSbJ3q8PRyq7WBxge8p4N1lc9U08mBWyM5efYokfGgVOK2bQnHjlR6BNJb0o
         taafswjfAGmViDc7rHpteSRWt/5qTPBE7vpJa8Txf7iTjK4vZXyvDa7V8VP1HFaYdBO+
         vhu8bcHwtcSm+GZgeDfHY/+cvmox8teVIlU+dzJJhY191Gr+3bYpOi3gMiyK2Yrbe9o6
         OdqrtXhjMp+RO3ydtlDY81VxX4h30qN647dJjHRcO+e2Men7K774d9rRjQXeYXEaSykg
         c1upDgLGLMJELKdUV2VBDxGj2sbLPaGAInN8qFzSp7J+Ig/ryu1AGtDglrFGgUrDuVKJ
         coHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=imuLUt+k8VCUVCb+R1LYWvu/bASMK/g1Jkrz98iL/pQ=;
        b=jdNE0d8sTe8MY1gqCmMW160JOyUB5saDFvWPLJKn3fDpfjIHfruPNr3nMwexF7HAxb
         GKww6t4rjA7af0RLLf7odtjVF7fyi2BuEfCKTrCoLLOmhrY8usEC/WfA+LXMguceE2xZ
         XDeerldUu/MJvBeGgFRyl0tATxTdNuDF11Gsw+2XmqnKeDG40F3/AHRccWKvXxt2fSKW
         5oG2avtB7er73pNtspnCvYdQV81RJIHB3qsgfHb+OAiL86R5mwFk/7IufvjiHMyaUe3v
         8SREmXU7Zk/tF97FTime1TtG6Sr3X83nG55uvoq+Tr9RKg+E+z6yPqzEQT9hpAfH1gaf
         QLaw==
X-Gm-Message-State: APt69E2hV+rnGrRJeXBbYG0uXAwTT7pkJBvBsQcK4VWfs2T6bctBqD+u
        luAxcquc+rJ8zMNDB9a4cOzbX5G4
X-Google-Smtp-Source: AAOMgpcweNKB+u35HgjBsG0Ew8JR7GU2jDvTicuxG+gojP6rg1vnx5EyxwOSfLE4dfqqZoZYcK2O/w==
X-Received: by 2002:a17:902:7481:: with SMTP id h1-v6mr28726048pll.183.1531303493539;
        Wed, 11 Jul 2018 03:04:53 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id b65-v6sm33136297pfg.34.2018.07.11.03.04.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 03:04:52 -0700 (PDT)
Date:   Wed, 11 Jul 2018 15:34:43 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Brian Masney <masneyb@onstation.org>
Cc:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, jonathan@marek.ca,
        jmaneyrol@invensense.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mkelly@xevo.com, fischerdouglasc@gmail.com,
        bshah@kde.org, ctatlor97@gmail.com
Subject: Re: [PATCH 2/3] iio: imu: mpu6050: add support for regulator
 framework
Message-ID: <20180711100442.GA30019@himanshu-Vostro-3559>
References: <20180711010932.20313-1-masneyb@onstation.org>
 <20180711010932.20313-3-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711010932.20313-3-masneyb@onstation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brain,

On Tue, Jul 10, 2018 at 09:09:31PM -0400, Brian Masney wrote:
> This patch adds support for the regulator framework to the mpu6050
> driver.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  }
>  EXPORT_SYMBOL_GPL(inv_mpu_core_probe);
>  
> +int inv_mpu_core_remove(struct inv_mpu6050_state *st)
> +{
> +	return regulator_disable(st->vddio_supply);
> +}
EXPORT_SYMBOL_GPL(inv_mpu_core_remove); ?

This is causing 0-day test build failure perhaps.

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
