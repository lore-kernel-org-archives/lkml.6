Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFFDC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523D620856
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOjpqJ+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 523D620856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730947AbeGSLIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:08:21 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:35072 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbeGSLIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:08:20 -0400
Received: by mail-lf0-f50.google.com with SMTP id f18-v6so5642262lfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 03:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=efAZpmbvOSwHt9aypkIev5gVvAbAz8Kfn7cn8D9W4LY=;
        b=HOjpqJ+NTFT04OQaxC15N1TbVSmG0dCgDx3NRTC7KiU3W6AcUpTsye6dh2ImyVg79k
         YYgEjrWjiDVbKlsxvlJrzxkt1s2Aby/vkK+9xXts7XXFNO9UZeSlWWBaa9IRU+Q+WVQ6
         3rRJVh3cY5XRgazH88Q5bxmTjPXa3+4uSfdlSFyDUf2A51/wEYsyqnNzrHR6PfbSuDED
         uEz+Xssvbd4yjHL+6U/HwAD3pUJnink9VqZFhG2SBMkq85iiMvXwFHRG3I6LIjRoBm77
         FHKvTuFFbxrgVUVXgnzvpDFLoPMFIC05ZN+QzZwaqZmc16wcEAyjU+hupi0UhVmDzMGR
         1AkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=efAZpmbvOSwHt9aypkIev5gVvAbAz8Kfn7cn8D9W4LY=;
        b=Gme1evjbz5420q1WJEpoXySxw2i2oiCFS2wWKaR0ly2gp1BodX8mrqtejdogHGa/5d
         7c7h5ewG+zAqJxUIyBU91asD4VcY9kZvLiF2XY9sP8IvghgtEy/sLV08P528PILlDlfu
         aClsxPtrV9033mH6lXMolsAZSSa94iLjT/yVqfrxu0nwAuhSXn6ErS5ZfJRvU6UbFLqw
         JEfEAEs+lt6WG9FrKj314slOo5OpNAcf4/8oZMOsFKoVvdOF1zvZcqD0ubtaM3trNSOk
         z+PpVCRlQK9PXabl/CfjiJcEreRpckWBYdK6cdVrTNw+bOWSeaYiTwR8MN5K+IqTncez
         27Uw==
X-Gm-Message-State: AOUpUlFWnYkMgiu7U3+W7QImVAK0it2ep81EA9N4Kqvmmo0CDEZV0vfn
        sS0Jm8pASARIvExfU68dYP2IG/j0
X-Google-Smtp-Source: AAOMgpcILK0Axo8gjtgqKYCL8Xdo+7tan+AP7oG7mCcvUdQ5vI4FGLhGWYDsop1EieDe45HWQZC3Ug==
X-Received: by 2002:a19:385a:: with SMTP id d26-v6mr6606211lfj.47.1531995950660;
        Thu, 19 Jul 2018 03:25:50 -0700 (PDT)
Received: from [10.17.182.9] (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id g16-v6sm1031544lje.1.2018.07.19.03.25.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 03:25:49 -0700 (PDT)
Subject: Re: [PATCH v3] drm: Replace NULL with error value in
 drm_prime_pages_to_sg
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org,
        gustavo@padovan.org, jgross@suse.com, boris.ostrovsky@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180719093713.3643-1-andr2000@gmail.com>
 <20180719102416.7gnzuo4vmax44qv2@mwanda>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <d11c3a5a-fcd4-e4cd-683d-cb0384d35757@gmail.com>
Date:   Thu, 19 Jul 2018 13:25:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180719102416.7gnzuo4vmax44qv2@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/19/2018 01:24 PM, Dan Carpenter wrote:
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Thank you,
if nobody objects I'll push it to drm-misc-next next Monday
> regards,
> dan carpenter
>

