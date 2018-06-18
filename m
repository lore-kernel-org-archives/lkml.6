Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED07C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F0620693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="lBdPgCbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F0620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936681AbeFRTcS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 15:32:18 -0400
Received: from mail-pl0-f45.google.com ([209.85.160.45]:47094 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936376AbeFRTcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 15:32:15 -0400
Received: by mail-pl0-f45.google.com with SMTP id 30-v6so9555167pld.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 12:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2zB7LTy44gbYcid4s3hV1Z4a8cFskU97j0PFZjMKnu4=;
        b=lBdPgCbrI+xQ7f44hTdEfPgcFQ9J+eb+PsP+5BTWr+Sd68Ho49FNFyMrWey4Fi81U5
         y/fuxZJwYwGCy2ZxyoJEsfuh4ajN5YYOWIqdAkEf080i3aO/XSM88AzZsqNeHLPM5L4v
         b21jGlYj5B1pcCvs+CeZlc8SQNLMAwZGkG8xzSPezwqcgfHEG8PdVFkvm1JKQo+mrj3G
         UCIuyLX3ZYEMWZM3oq5Au0STcwC7mB2UFeq4Mka+nFCfyObIucT04PS7X+0LawkcAurx
         fmSzrKMnfEkS0Cg5hSeepi+sxi+XCVuVQ1uzNSWS5kek6c3P1+u+M1C4EUnAYFN7ecWy
         QDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2zB7LTy44gbYcid4s3hV1Z4a8cFskU97j0PFZjMKnu4=;
        b=kAnfoJhnzimQDIXpi3VD9hRaEeS3eC9UpcJSRGBo0/vQHs4cDFEsO5Ls8dW+Qu7Egb
         jzQs/+Xp/8M+SW3+PV4GZ3d/qw1CINtSM1Gjq+3hXCbZEImFS39o0jjlIoy8PCqu/kVR
         dgqQs+4cuPcGmRhrbamzG6fB3RSsS3uox9wIuLUThFGsjF4KrzxNKPRuB9C7VjHkWP5S
         DyKyNOeyOa6SVJRMkICZBEhkc+dOYFjE9qTy9mi7jsWU90ikVZXIlUlKvO3LRo6ghH4S
         xei4kj39m174yXh5skh6H+jQbdwtM+PT3DINWXrOUsxBREMMgbLzBQqkoVNK+cTIIi6B
         eMqw==
X-Gm-Message-State: APt69E3P+LMVFZyvI8N8dJvnJcFyHJbw1VQDPUYnFzft4DKrIgZDq7r3
        bALQjA2FvcgKn6NzqPa9sZBcuQ==
X-Google-Smtp-Source: ADUXVKLyFA0A8fmFh1HW6jB8XR+ofVT0rpHfOKLOzoWX91kxoSM2xvxzWuejhAqqPRQA3IpWu2UV8g==
X-Received: by 2002:a17:902:a610:: with SMTP id u16-v6mr15429748plq.195.1529350334799;
        Mon, 18 Jun 2018 12:32:14 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1611:6077:8eec:bc7e:d0f4])
        by smtp.googlemail.com with ESMTPSA id i4-v6sm24023667pfk.133.2018.06.18.12.32.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 12:32:14 -0700 (PDT)
Subject: Re: [PATCH v2] overlayfs: caller_credentials option bypass
 creator_cred
To:     linux-kernel@vger.kernel.org
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>, linux-unionfs@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20180618192726.67981-1-salyzyn@android.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <afbcabfc-2e25-d2fc-107a-5418b5e0806f@android.com>
Date:   Mon, 18 Jun 2018 12:32:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180618192726.67981-1-salyzyn@android.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/18/2018 12:27 PM, Mark Salyzyn wrote:
> All accesses to the lower filesystems reference the creator (mount)
> context.  This is a security issue as the user context does not
> overlay the creator context.
<sigh> been typing overlay far too many times, muscle memory struck!

"overlap the creator context."

-- Mark
