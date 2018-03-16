Return-Path: <kernel-hardening-return-12664-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsiRprlCc6eZjUoDtCa11Jim+vY1/P6V+YmQx59kc9UlQ0waxeGjSg2+cXm09QUyj5zubz4
ARC-Seal: i=1; a=rsa-sha256; t=1521215822; cv=none;
        d=google.com; s=arc-20160816;
        b=Ki93pl6ZGoL0Dd9/XdVoHAAPHaoDsKG+jaRjObaiOUeGMd2j5GvX0xMNKqTJUaz1q4
         MOtgn/Nl/Q4bYDMm60OAHxXi8PjDMEq9Hk7GprcIwP2AcwPdOXLJsKVS/VevN5Yr5iE6
         pIVFP6ATLKEnqTELUblVuse558xcNAU0/D+4cFinZGbXURE4Ra5GHKGPySbDDRjLRu23
         qsD+sKLhwldevhN2aNvB8vCmFpb159ZsPdDA3dw1nReMkrqR2Qktt9xhlHUnrenG3YHs
         6SdXtDb4lboqoRJ9KX+eygbpPRJj+nDYOaXNsFMDfZgTw0X8x+aU0/VuZxInPtsO7XPB
         j9qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=FqdoCP46nWxwm/WxROyUWYk9fnPucxmmGKExljT0/fM=;
        b=VpC9K5GUEL+RIgWS+A4ylaVM79ayq9hkQWjBQzZVFU/3iOZKAFC6mpNxTsVibx4TYk
         yW4IPFE9HZa3gPuOwH8lspE0M1YsEHhav4/PRM+IuYsSheX0owYO4oKiBcXLkWGdht0W
         UPYE8i1Bu9TUB289mnPkan3/K1Ig85q+cWTCFwtxFmG/TuZjCLBZGtciOmTyndeuDPIc
         Od+CmJO+Mt6lbTLtfdvSk6NPXaQEDnfxi4/ky9fkWAnB2TIVWzE1AnHwBtgKt+zHDnUU
         se9QIT1X9OUKd+ENDxvqTRyfAw8cF2Qa8M6mElUu0OZaN0WZDWAnxibdpjjw0NwsVA4N
         zbIA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12664-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12664-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12664-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12664-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 16 Mar 2018 23:56:32 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kees Cook <keescook@chromium.org>
Cc: Tudor Ambarus <tudor.ambarus@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, kernel-hardening@lists.openwall.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] crypto/ecc: Remove stack VLA usage
Message-ID: <20180316155632.GI7095@gondor.apana.org.au>
References: <20180308215702.GA9902@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308215702.GA9902@beast>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594317666211482580?=
X-GMAIL-MSGID: =?utf-8?q?1595110402479339571?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 01:57:02PM -0800, Kees Cook wrote:
> On the quest to remove all VLAs from the kernel[1], this switches to
> a pair of kmalloc regions instead of using the stack. This also moves
> the get_random_bytes() after all allocations (and drops the needless
> "nbytes" variable).
> 
> [1] https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
