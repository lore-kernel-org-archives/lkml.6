Return-Path: <dan.carpenter@oracle.com>
X-Google-Smtp-Source: AG47ELt6RD6QXbPpjj+y/0C4w9WbtIC0NdH0lYNGhuLzQrSWrJHmvrIhgo/5+cg4eafOVEfdn97z
ARC-Seal: i=1; a=rsa-sha256; t=1521544869; cv=none;
        d=google.com; s=arc-20160816;
        b=t1PKT9uEiAcqVv9kr6MaIH/BnIHlrmbICLNi2QhDphv529vlhV93sO/lPHjU4o1xvC
         ddEhjmlEEq3j0t0ow8K6YdXj9h5Ugq8A60n1y0A/rK4a9QT8Zhn2t4oGgpswnZDb/BDU
         kt1E2QuyLjqme4fYt8vaPR/RyDNzscK+8FEZx/oUZ5axQGetjIpD7IwE7+N+X477AsE/
         ap1rzn1ULJF/B3Yz95eCwGvNZnQUeXmYkIiF8j2MwnOpJFVTQ9J3fSrovcyQ+qn+fWM0
         YCGeICCOkumot5pe+WRHBZj+VbwLtpOqPlopoKP1XvCU88Fqiiha1qqcMC9nKBCOHdKo
         cjKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=I819Igx50aPY5yB1F/TuPtoDfMlJAC+puWUMKWfZMig=;
        b=SWILRrghKSOzYhnoiiTFsgEQNGZsBVuwS4/Ut8ocGVTC21a91cnXqoTmyw/tr4ittL
         kIJA9xVeNeHBgosMk+x3EYTpXIih6adK/iS9/j6ngF/UWTLGgEpMV7u/7EYDWSwKsqn9
         QZPqa1GmaU0GrFecn4aF3WAAxSYl8jeffw3DH7/YeB7bab9++omLYMHWo+xUmFeFwynr
         SY9QTuQiLaQBRdX7UCLJtcfbAGBXp/m4wl0rHCy8P0zZrtkRN5IiYEgu8o+++CTKvrkt
         Om15cb+RFA2XO7dPFq4vfAB7pPskzsIOT+bgRGRGcdlMbnaKynfKYrIQokdjpUQ+Eu7c
         AmVg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=HpdcE/ya;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=HpdcE/ya;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Tue, 20 Mar 2018 14:20:53 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Pratik Jain <pratik.jain0509@gmail.com>
Cc: arnaud.patard@rtp-net.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: xgifb: XGI_main_26.c: Refactored the function
Message-ID: <20180320112053.zxudtqeemedogcel@mwanda>
References: <20180320083549.6795-1-pratik.jain0509@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320083549.6795-1-pratik.jain0509@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8837 signatures=668693
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=507
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200127
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595445043191954085?=
X-GMAIL-MSGID: =?utf-8?q?1595455433220449950?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I'm trying to review this, but I feel like this makes it slightly more
complicated for no reason.  Why break it up into two loops?

> -		i++;
> +		++i;

These are equivalent, so you should default to accepting the original
author's style.  Otherwise the next person to touch this code will just
change it back and we get into a cycle of pointless changes.

regards,
dan carpenter
