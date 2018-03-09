Return-Path: <kernel-hardening-return-12316-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuSAsGFgAEHjyOSj3xjhKjOMrlGfjixuOQGMODHFMD4iJmVovFzjgGEJMtdal8U/pNowxg2
ARC-Seal: i=1; a=rsa-sha256; t=1520599163; cv=none;
        d=google.com; s=arc-20160816;
        b=rPHI+aXZdVuOj8s2jMOKsuQIZhu9FXzon1oToZ2i1Dxk3yAkddE491kkMcpMqsKKFv
         BWJeuEAKstUfTxsxNpjVvZt5yzvCJ4hTRw5KALcnKEKmdxqq6yngC5sRt+IKijxwtHex
         D8dyZpqoSDn6hS978c3SbKg++SdTTXAF8HtZhFmM3wmj7c5yn5hZuybIg6WqTfikOSYt
         B5foUt4tudivOzVJuRjrO4mcyA0Z9cm1o4K0YB+rkL0ZLOBYyemZXFJLs/WrnXrJFWUj
         dXbVmIOnuGJn8C4254n9kaZtJslTcYDZB+nY8ZDNr97cFoNqfj3PN6UYrDZVoHTw/426
         zfsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=MSyDJDXQ+Om9kCzQ1LqKi9M7R3+sxXAxDu9Co62YdXY=;
        b=u5uCkvCuRXtb+CtTPtVPIRXbJ1fPyeva65M7t6bJWyHbXeikbI2UDhAAwGGU6a1IxP
         INstdUYKRPFjF0LGOcMPN8bTyixpw+F+R9xbw1qdpnRxfAHdntcBqorGoDVwdPm7+0tI
         Ox/g10FTnzDEEnuCqHHSr7BYST6DlFPVxMH55ETRdTIRDNizd1288vXoixv5yHWxNEnA
         To4bsLJw8NJD/wkFyEeJJ14U+CjdmQDgMFE4UnFR9EIQNShnlBcjYJln84D8cxY8WOy+
         w3THsQgs9e+i5KTTbcA4e20jfmz6jmuTuC6KV0Bu/QDeI/1PQoRAY8Y6gajRInkBRSRJ
         3z6w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12316-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12316-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12316-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12316-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 9 Mar 2018 13:35:43 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Andreas Christoforou <andreaschristofo@gmail.com>
CC: <keescook@chromium.org>, <kernel-hardening@lists.openwall.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI
	<yoshfuji@linux-ipv6.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: ipv6: xfrm6_state: remove VLA usage
Message-ID: <20180309123543.defont7is6fyxt4d@gauss3.secunet.de>
References: <1520598106-3271-1-git-send-email-andreaschristofo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1520598106-3271-1-git-send-email-andreaschristofo@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 557E90BD-3FDB-47EB-AA99-3B86F96210FD
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594463771060382720?=
X-GMAIL-MSGID: =?utf-8?q?1594463789265865432?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 09, 2018 at 02:21:46PM +0200, Andreas Christoforou wrote:
> The kernel would like to have all stack VLA usage removed[1].
> 
> Signed-off-by: Andreas Christoforou <andreaschristofo@gmail.com>

Can you please explain why you want this change?
