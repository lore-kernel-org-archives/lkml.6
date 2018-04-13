Return-Path: <dvhart@infradead.org>
X-Google-Smtp-Source: AIpwx49/7mtKdhE5/pnEm+OIWRtgXhhiW72ByR12jw+jyiGwptgMetY7leU08/+yzWwT8SNOrJNR
ARC-Seal: i=1; a=rsa-sha256; t=1523638476; cv=none;
        d=google.com; s=arc-20160816;
        b=QkKNAyw4idzXheYBFTrxAy7sQMJLjQ1lmv0CdgHycNlBDhVC8XQMXfzLFMlnqtOBBt
         w6rS869dBFD1jO/VGTDgLNx2E6CfrJ6yBCG2XS+zAYj1R253XZ5jg3ouC4nZzkAh7MGx
         yqGxaTCayR/qArRSRdC4/01RdB++kks6jVsKE7QuEo/Cc0TWbMNIgeP8cXZkuxRkfjSC
         GofSFRWnMQ1L2WPXqzcH58OxSwzUvrVKsq2trzH59xW/jtzR2JoyPc9SKCvhTSF0yWGg
         Ko3wDwCR7XFZJxxSpVXHQQx/sAEbGM+ji7iGZNPA3FC9ainVrNuC3XRhZva2isJAQ3Si
         69vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=xb3xCx9Ymh9obC2o5os4UUkamwXXz1eiSHbc7n6abnk=;
        b=A5f/HNwJ0fxuhPzayMQxB0YPFyxyTaM9SllaMrX2cpv5aLHWc7NnNWSS58iapl8c/c
         600nUcSGgi/Fg4vjBvUamCmC4Fs9yRGpDCVZ4772MivJcIUME8odnJF5tzhEZU/nZGxj
         uSRsAun+g1gQ/9VAus3hODxAVxV+eS5m8KZfT63Z6R5XO6X2EgPQrt5iF2pbzD+q1wqv
         dq9Dct70FJPpU+voim4I2I0xXxD+VMz5TYKpyWNbisiZPeNAaSCg4PHDelhlo82g0sIf
         MoL3HcasCbAGTAb8XsumFlGitGkLfwPN061kQYVXA3Lq9IM6qJoYLSf5ge90niuWweGM
         feCg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=RpSYDMxB;
       spf=pass (google.com: best guess record for domain of dvhart@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=dvhart@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=RpSYDMxB;
       spf=pass (google.com: best guess record for domain of dvhart@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=dvhart@infradead.org
Date: Fri, 13 Apr 2018 09:54:33 -0700
From: Darren Hart <dvhart@infradead.org>
To: Vadim Pasternak <vadimp@mellanox.com>
Cc: andy.shevchenko@gmail.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	jiri@resnulli.us, michaelsh@mellanox.com, ivecera@redhat.com
Subject: Re: [PATCH v1 4/7] platform: mellanox: add new ODM system types to
 mlx-platform
Message-ID: <20180413165433.GF27560@fury>
References: <1522144927-56512-1-git-send-email-vadimp@mellanox.com>
 <1522144927-56512-5-git-send-email-vadimp@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522144927-56512-5-git-send-email-vadimp@mellanox.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596077330575695647?=
X-GMAIL-MSGID: =?utf-8?q?1597650739413272256?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 10:02:04AM +0000, Vadim Pasternak wrote:
> Patch adds new ODM systems, matched according to DMI_BOARD_NAME.

General nit. When writing your messages, please use the imperative (command)
form. Rather than:

"Patch adds" or "It changes" use the same form you use in the subject lines:

"Add new ODM systems", "Fix struct field documentation", etc.

Again, I've been rewriting these, but as a regular contributor, this will help
reduce the overhead of reviewing your patches - good for you, good for me :-)

> The supported ODM Ids are: VMOD0001, VMOD0002, VMOD0003, VMOD0004,
> VMOD0005. It doesn't introduce new systems, but allows to
> ODM companies to set DMI_BOARD_VENDOR and DMI_PRODUCT_NAME on
> their own. It assumes that ODM company can't change DMI_BOARD_NAME.

You said "it assumes that ODM companies can't change DMI_BOARD_NAME". Is that an
assumption, or is that how ODMs work with Mellanox?
-- 
Darren Hart
VMware Open Source Technology Center
