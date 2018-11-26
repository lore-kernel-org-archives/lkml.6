Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55CDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48E4208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eDlyQDgB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A48E4208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbeK0Joy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 04:44:54 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36312 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeK0Jox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 04:44:53 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so6867388pgm.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 14:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D6UsZLpgKcKaaNcTuC+QTsEBXJeJwU1GAr7xHcHhk+o=;
        b=eDlyQDgBcO7oiPtxumoe9/GcQo1mkzUYYr/RbbGOwG/x5JxvfrphdNsf9pxSEu0sju
         4ZbW8lKw9BtFuAJbDfzSxddk6r3g72ZKM4eZAasugV57HP0+vqeRtA84KNAKffM2mU2u
         ce5hwojixNsukS2BSIT3sdShjeNefkF2BIacRy2BcqA5LPsRhqNSzLS/GdwFuuPrHLpw
         1FosR0tnJvFzX3LTWzQ3zPfGb2s6Utoih6hba0uI5wVFE1FLVtIgswxFLuPFudkWsg31
         5LTkH7vos37ZS/mPve2G8tP66QfTGMYf96BjkPMeWXOwyjrOl297q1Jd+bYzCrGAEogP
         ojoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=D6UsZLpgKcKaaNcTuC+QTsEBXJeJwU1GAr7xHcHhk+o=;
        b=VA1Qqw9k56txz7TEUc7WHztLtTgnKVBdNyMAOlemG9O4Y63dggYZ8kDPcaHjtV2MJv
         2tevN4IGnPivOsTG0CEg47CwsBDewydKUGSjNUVs8peDRplGCEYE5lm3PSgIi6vVglzV
         +u9GVc4pdsTM98OBzwf6Hb5CJoUNaxdJuVP1piIF8B+F7e26dom44AE3EZzRrFTNuBIt
         GnpBUSqDs61W/Twl7mw5JqYXm0FcUYnNeZgzQnxc6nGsVi9QNRRqKpGA57rsxaSdQmXw
         lq0xCgMs3anUTlMPePsxtqaLiduyZ/LJUqSO8P5XABrVW8j+cKGv+CHcCMMeXDGrgKHl
         uW9A==
X-Gm-Message-State: AGRZ1gIOVtjJXKOCsQKhLNbxJEIAOEMnVA3dz12sglH1dGPyRzRK1ENl
        qOBCgPU96gxga/YJLoCGi2E1gw==
X-Google-Smtp-Source: AJdET5dAhHGi5IYWbgwcOBXiSFYs3W8b0lgl2XIYts6v0qnjthaz/qDcCuchGuvn1A8RGMYjKTKfxg==
X-Received: by 2002:a62:8096:: with SMTP id j144mr30581680pfd.140.1543272552496;
        Mon, 26 Nov 2018 14:49:12 -0800 (PST)
Received: from js-desktop.svl.corp.google.com ([2620:15c:2cd:2:5c1d:6557:d90c:ea99])
        by smtp.gmail.com with ESMTPSA id s190sm1889411pfb.103.2018.11.26.14.49.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 14:49:11 -0800 (PST)
Subject: Re: [PATCH 2/3] kvm: rename last argument to
 kvm_get_dirty_log_protect
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <1543251253-24762-1-git-send-email-pbonzini@redhat.com>
 <1543251253-24762-3-git-send-email-pbonzini@redhat.com>
From:   Junaid Shahid <junaids@google.com>
Organization: Google
Message-ID: <bc76c8d5-2e79-65c8-2b7b-46f2e8d8b001@google.com>
Date:   Mon, 26 Nov 2018 14:49:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1543251253-24762-3-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/26/2018 08:54 AM, Paolo Bonzini wrote:
> When manual dirty log reprotect will be enabled, kvm_get_dirty_log_protect's
> pointer argument will always be false on exit, because no TLB flush is needed
> until the manual re-protection operation.  Rename it from "is_dirty" to "flush",
> which more accurately tells the caller what they have to do with it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/mips/kvm/mips.c     | 6 +++---
>  arch/x86/kvm/x86.c       | 6 +++---
>  include/linux/kvm_host.h | 2 +-
>  virt/kvm/arm/arm.c       | 6 +++---
>  virt/kvm/kvm_main.c      | 6 +++---
>  5 files changed, 13 insertions(+), 13 deletions(-)
> 

Reviewed-by: Junaid Shahid <junaids@google.com>
