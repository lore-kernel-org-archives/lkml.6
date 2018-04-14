Return-Path: <kernel-hardening-return-12997-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+LO2AtlV04WVv8ThbgwnMsiXh494bm9tm50CDnl42WR2Cy9pOSfbpWRp7irxr/0sOs8+W5
ARC-Seal: i=1; a=rsa-sha256; t=1523697155; cv=none;
        d=google.com; s=arc-20160816;
        b=epIDx+JKIqDuRrEVC61kKuwXjb+x6wR6QRFyaoyYtxk7egF28LNPLRCvOAeVwzZoby
         V2QY7jflqMlt/5++zESdVbTqJoS/5YVoXsfPloFqgoAq6/96QP9Jw0JRmnEuXX7arnc6
         J+9QIwxtVsnIbACresCP/xfEgizmgQmfeDQ36PSBtqA+re8BkFrde4IArQVx9aSEfWum
         pTmGv62QY/qnFd1kD4SeznIFyLEx/dh7dYqxmtg1MGe6xGoZIE/4iWzU9+9FARwZsR/C
         BmgBRvFhnYHi5hj14+EvUSHXExGiU+3hhQnhhacaXbrU+EhILEzVUqsIFWMiuXZIKFQn
         p6LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=Oz2L2EkJCb6CHuS1AW9VgzWufS7vk27m/s6PdWkp+cs=;
        b=OaznH66ldxkcTvf56GiEZAzhT6F0J1wh7ruiLz6/ZGtKoyixnpUt6bxgLFz0B9kaPc
         2/a4RjOmof7FAKJa3zT2HMxLhCsKsFSQFrNkQL7WVA0T4huFoVGVhhmRuBZXJzR3CTDL
         mlzq7jm6e+yIoH+GILukaIZBe2mRlokh5DrFGU+tE/uryaJgiy07W1dMAK/R2s5fZIf7
         L0c38NRQelAXOYHrf1uYov6gT5iXfwrWVa9rRYq6YsGApog1P4XdReoyWjY5xiXumnfS
         yt4rwihFCxA6kqaxIvC3j9mvFNkCsVW5EhIcT9pzdM7knNXmjMU/SaYVU0xDDo0I8Roq
         AJYg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=j+LS4Ssw;
       spf=pass (google.com: domain of kernel-hardening-return-12997-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12997-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=j+LS4Ssw;
       spf=pass (google.com: domain of kernel-hardening-return-12997-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12997-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 13 Apr 2018 20:55:53 -0600
From: David Brown <david.brown@linaro.org>
To: Laura Abbott <labbott@redhat.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org, xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH] x86/xen: Remove use of VLAs
Message-ID: <20180414025553.GA32653@davidb.org>
References: <20180413221146.28476-1-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180413221146.28476-1-labbott@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597670729617678421?=
X-GMAIL-MSGID: =?utf-8?q?1597712268736378427?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 13, 2018 at 03:11:46PM -0700, Laura Abbott wrote:

>There's an ongoing effort to remove VLAs[1] from the kernel to eventually
>turn on -Wvla. The few VLAs in use have an upper bound based on a size
>of 64K. This doesn't produce an excessively large stack so just switch
>the upper bound.
>
>[1] https://lkml.org/lkml/2018/3/7/621

This comment is more in regards to many of these patches, and not as
much this one specifically.

How confident are we in the upper bounds we're setting, and how
obvious is it in the resulting code so that something does later
change to overflow these bounds.

The danger here is that we're converting something a little easier to
detect (a stack overflow), with something harder to detect
(overflowing an array on the stack).

I guess the question is twofold: how did you determine that 64K was
the largest 'size' value, and how should reviewers verify this as
well.  Perhaps this should at least be in the commit text so someone
tracking down something with this code can find it later.

David
