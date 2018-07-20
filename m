Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA91ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E4C20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRt8hjO2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E4C20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbeGTKwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 06:52:45 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:39350 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728920AbeGTKwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 06:52:45 -0400
Received: by mail-ed1-f46.google.com with SMTP id w14-v6so9323120eds.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 03:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1pKiJL3XTjY3WG10AcWexLxucV0JNmkIYGLvOBdo5xk=;
        b=sRt8hjO2uJkkvUvs3jODCWLpPPKXyBgWVRghekZ9c+xkJEJD0WFlGjJgNtDHMkYsxS
         w/Qpg8bOHx7wX0syRPaskHLKJwXKqZS22gww9cLoB6QTlv4LHPEd2qdAlVHo0i3UrS43
         L63js6n25FqMdgvRCWjkCzHpVrQnBoZlW9tk0UQ2P1TAnNTUboyzT/0rk9MRa/s7lPuT
         1hVk7zfYATNgDtZomkJWkngtnJrJIu7rmP8TvKvnrwOLLFVjjgM8uKXlw3+44dENU/aB
         gywE+e2p40nplfpwL17KWQTyqn0Tx88yaKNtt1qrxCasv/7PbqYcHf6nv+F2aox/S87S
         rQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1pKiJL3XTjY3WG10AcWexLxucV0JNmkIYGLvOBdo5xk=;
        b=to2bKRs5vqPFXOHSnny9hIyHwhtQTsWM7KAUiPr+8TzDfyngimMP00gxHlBKkXFIuT
         p2TluOm1ozYOrSnko7/fmEZkL/QGMrdU/fdmu0VqSlrCqOsEa/eg/lDVH/LmTPqBocTp
         arw7aasc6zPb6ZKDIcWlnGtxSDz0WuHTJQISpDzkqCnr1EJvLrHSP1f1xOQVPPjaQ8bh
         gBrCq1jWI+iY/AXf4BBsB/al/q/jM0P8nN3+Nyffyv07YSCtnsMPqp6XakpSPjKjAp5h
         lRH0cFHgyhlLk1JK9FHIfWgsyQ862QEJ/9O8l/mOtB8Fzt/0OHNeVkJygYnTTaFnRHf+
         uQ8w==
X-Gm-Message-State: AOUpUlHMZQohTqOIyc+bVqgMJEN6Te1rG21rN8EixL/uKChRuD2TlTm5
        EVNyb0qxie24CTUSCqC/xg==
X-Google-Smtp-Source: AAOMgpeUYyMtSL97i8nv+Bl2M3NkW719CS+0XSACz7jtqOlfC8HIZ0f+/rfp/JpZtO70BI5NZLigVA==
X-Received: by 2002:a50:a0c5:: with SMTP id 63-v6mr1833155edo.47.1532081113569;
        Fri, 20 Jul 2018 03:05:13 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id a53-v6sm1634521edd.35.2018.07.20.03.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 03:05:12 -0700 (PDT)
Date:   Fri, 20 Jul 2018 13:05:10 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org,
        n-horiguchi@ah.jp.nec.com, pdhamdhe@redhat.com
Subject: Re: +
 documentation-proctxt-adding-hardwarecorrupted-field-and-description.patch
 added to -mm tree
Message-ID: <20180720100510.GA6044@avx2>
References: <20180720000108.Q6IZympcp%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180720000108.Q6IZympcp%akpm@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 05:01:08PM -0700, akpm@linux-foundation.org wrote:
> +HardwareCorrupted: The amount of RAM/memory in KB, the kernel identifies as
> +	      corrupted.

This is quite vague as the line doesn't say which criteria kernel uses
to identify memory as corrupted.
