Return-Path: <kernel-hardening-return-12307-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsPNJJwxuppMh5NCKpHgyVQlo/woo2QdDrTsEUgFfxHaTeieaRmd9e0KA38xFGrCE4f7fLi
ARC-Seal: i=1; a=rsa-sha256; t=1520584301; cv=none;
        d=google.com; s=arc-20160816;
        b=zqg9U15NvhF3BZuKsYIfmpsqe3F6oZj/jY+hgMUl1PylOL6VZgvJlpjrLWFpNmqUtA
         z1VXBJuvv5w3VKIO2rdWNdQVUZzHzKRCBezaBWnt3nTCmsvnnRyW3jVX3QPSPaUMn9tH
         sVhwtFpL98WI80qeO/X5Cf/PlrCJM8ar9IbQjkypjhbOhmdADtJaXkX/C/LAOVyaibti
         U/5Z+NZu9LkcQOiBXaqXdI3uQL9AIkxc3Y3Jvc6IH16kbKRe0rlVhmq7AGo3PWjX6Wjd
         oWsfjqDj6++XBk7/5oySdaWKShQWSMXdO3SJ74+4xVEnlxV2sPjsBlg1Ew4FHIm4I/kA
         7NVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=RFWmacImkxKAXRgy9ibDM/e1Wn8adhtduL55l0ysrCI=;
        b=cvjThXlkRfc6Qy+gNcqE22gaCQGO6oIckHdeJ6dUxD/Bm4B0Ha6BJ1ZQBCdbRDGoT7
         puGLnqbz0YnPLxcadCVOwv423Csg7lDOWuIeDHs3aNi0nWyTK/yJamOOZvainOtIOAIQ
         WW5uLUdB7wNcQybGm3slTbOQ/tglUlOrg0+fwXmuSsMsE+ij2Db10dqWGzdGrOEId1DN
         8FwzRPYI4qzI29PsnTLSdFnPm92u+miZPHJnaE0kryjyJ9R+6yPnfOHYpxYUjo3Ot07l
         MH93a1YPl7Cn6aAnv0C0RpIuVOzf6tGlS058DUBBnwtdqVFRN08QRYXGmW8+62PikIFf
         aA/w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12307-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12307-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12307-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12307-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-IronPort-AV: E=Sophos;i="5.47,444,1515481200";
   d="scan'208";a="12769436"
Subject: Re: [PATCH v2] crypto/ecc: Remove stack VLA usage
To: Kees Cook <keescook@chromium.org>, Herbert Xu
	<herbert@gondor.apana.org.au>
CC: "David S. Miller" <davem@davemloft.net>, <linux-crypto@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>, <linux-kernel@vger.kernel.org>
References: <20180308215702.GA9902@beast>
From: Tudor Ambarus <tudor.ambarus@microchip.com>
Message-ID: <470bdece-b9a6-17fa-5dec-f4dfec51ef73@microchip.com>
Date: Fri, 9 Mar 2018 10:31:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180308215702.GA9902@beast>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594317666211482580?=
X-GMAIL-MSGID: =?utf-8?q?1594448204658936816?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/08/2018 11:57 PM, Kees Cook wrote:
> On the quest to remove all VLAs from the kernel[1], this switches to
> a pair of kmalloc regions instead of using the stack. This also moves
> the get_random_bytes() after all allocations (and drops the needless
> "nbytes" variable).
> 
> [1]https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Kees Cook<keescook@chromium.org>

Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
