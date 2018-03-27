Return-Path: <kernel-hardening-return-12774-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49kQr4eD7SeY9phcuXvpsfFMVx7YCt21ELXmFTHlp+H6vOAxIxhB4Kx+m5jp9D8pDD2IMzD
ARC-Seal: i=1; a=rsa-sha256; t=1522169731; cv=none;
        d=google.com; s=arc-20160816;
        b=JrJIicEDxoFne1WrPB2upvSByTOrlYxw46mKTT+8VP+grZ1PSeLpR5NBapcOI+LKZB
         Ix0otv+zN4lQ9UIeXBoXxFEkkvAofd+iq1DtmXuN4apPn1DTDPgfaldiyCRANSBPL5LD
         NV2nTwEvpBAOIBUchjD141GQcaKXkcwBRxrFK8xyV2ezkaMMjFtqJzT2o0PqgSxvMi5m
         ARAsvgP6pqdxWMvD1DpGd/I3HZpWvNbbyyf+eXWdFR+fT1v02Bg6Md8ylLabygxjOqag
         4xuc+4Rdx2pNpyk/OO/Ni2Lkq4NXX2JlJpTA/g9HGwGTIltB8vves2d2ep6/4AUwYjEK
         MzSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=ASqXgXpwzkisEKW3CrqM81DrXEg5OUzpajYdrTExggU=;
        b=WN/pYrkcIA61lIPw8mYyBFZFsqw2rd+KKt/hg9UHzS6umVJsX9flaZ9vUzkH+sG+tt
         OYa6RAdnYpg4tuIrvAEZl+TRPup+De6QBSZ32PiEWBSpM3/O0XyT0B+/xVBMPAMDy8eg
         YO/IJKIYMNC6IYMCQESnbK5MkpinmWm1/vwbXAgW2AoTjI0HJnxVf94FDfWv/eME5xTf
         FuYaTomTKYPqm8nqxE13oM6AVAiJwSQYjF31aD0J5IHZ4OmbxlUSo9hpS/orzSjsFe1L
         UFNOA8h6MLxHBtrIpgT8KdeL2AnUceeVJFdPwC2q5LZrHSFfhboFz+flIw8Z1/o3SdBE
         fKIg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12774-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12774-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12774-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12774-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 27 Mar 2018 10:55:09 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: <willy@infradead.org>, <keescook@chromium.org>, <mhocko@kernel.org>,
 <david@fromorbit.com>, <rppt@linux.vnet.ibm.com>, <labbott@redhat.com>,
 <linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <kernel-hardening@lists.openwall.com>,
 <igor.stoppa@gmail.com>
Subject: Re: [RFC PATCH v21 0/6] mm: security: ro protection for dynamic
 data
Message-ID: <20180327105509.62ec0d4d@lwn.net>
In-Reply-To: <20180327153742.17328-1-igor.stoppa@huawei.com>
References: <20180327153742.17328-1-igor.stoppa@huawei.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596105811324274585?=
X-GMAIL-MSGID: =?utf-8?q?1596110648120902596?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 27 Mar 2018 18:37:36 +0300
Igor Stoppa <igor.stoppa@huawei.com> wrote:

> This patch-set introduces the possibility of protecting memory that has
> been allocated dynamically.

One thing that jumps out at me as I look at the patch set is: you do not
include any users of this functionality.  Where do you expect this
allocator to be used?  Actually seeing the API in action would be a useful
addition, I think.

Thanks,

jon
