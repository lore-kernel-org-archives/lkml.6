Return-Path: <dan.carpenter@oracle.com>
X-Cyrus-Session-Id: sloti22d1t05-2392938-1521187757-2-14528371224432954707
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_MSPIKE_H4 -0.01, RCVD_IN_MSPIKE_WL -0.01,
  SPF_PASS -0.001, T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='156.151.31.85', Host='userp2120.oracle.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: dan.carpenter@oracle.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521187755; b=oGtXMJQr8z4mJ08u4ne229sm2tnLC0inUXeE/ukacTBknxo
    BduAuT9COy2TFWIlr41FarrkqCdD24AKVggOBWuwdR5uUNUlKPxxLsrsInRzGCuX
    K7PkSYrzSmeZ9QhHZnDGC5QSF5pxT2wiPJDQOah6jTbhk8JkeNuB87mZYWHqcd5W
    mWsR0+gj+Wn2AytrrrAw8A90biEWKEgG3z6ATs5efay+aSq5qPxCUHFOwKUXYnYN
    SAqJNdCmWsrgF5YlNi1PMUy4QTXcyNwADF9JIiodAgqHrJ81L8AcxC9zL55PygoU
    M6DC7Vtuc2Bq/hk5MtCvTr+k8Nh6EI3xBQJwnjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1521187755; bh=oXwz2dr/7VYg8iWXVh/aRjyI2UZLaEa/kMAn6CSIgww=; b=S
    mXY17Mqxem2t/FVYeVf/1UlYQpmU9vo1iWwARZMrpZu4w/XNKyDoFnzuBc8PtPjY
    YQtA2myMZBxfexjs3MOf8c6MQA650gtpqsOkEm8PtgRxMc7Y8jSueVMDjFy0tXsz
    sT98qrsMqdit2jH2etMqFLJBx7YSr/jsjC7P6GH31DQUZyx2Pss4JzzhWyW/F3IB
    KaxIV7kcE97bzTpys6Q3ZvWWSHfz326JL5yAlQAId29ONTmt2QcZlPj6ODZohR8n
    4Pq49+iHiuhd2X3yn2Rtyto06SFwcHsz8L9wQQs9zpj8AFHZ/aeU6cTIrqwOTpUK
    E6Lkx1xCUu0R8M8TJsVjA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=Xx+PL/iV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=156.151.31.85 (userp2120.oracle.com);
    spf=pass smtp.mailfrom=dan.carpenter@oracle.com smtp.helo=userp2120.oracle.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=userp2120.oracle.com x-ptr-lookup=userp2120.oracle.com;
    x-return-mx=pass smtp.domain=oracle.com smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=Xx+PL/iV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=156.151.31.85 (userp2120.oracle.com);
    spf=pass smtp.mailfrom=dan.carpenter@oracle.com smtp.helo=userp2120.oracle.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=userp2120.oracle.com x-ptr-lookup=userp2120.oracle.com;
    x-return-mx=pass smtp.domain=oracle.com smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Date: Fri, 16 Mar 2018 11:09:00 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Pratik Jain <pratik.jain0509@gmail.com>
Cc: Greg KH <greg@kroah.com>, devel@driverdev.osuosl.org, abbotti@mev.co.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: comedi: drivers: ni_atmio.c: fixed multi-line
 derefernce issue
Message-ID: <20180316080900.4ensj5hsqotg4jvy@mwanda>
References: <20180315173040.11468-1-pratik.jain0509@gmail.com>
 <20180315173934.GA30586@kroah.com>
 <CABbwmYcnDNcA70_-BhLkBcuK-77tk3BWKcvzQts6eWqu5_mMKA@mail.gmail.com>
 <20180315193246.GA1565@kroah.com>
 <20180315194912.GA20259@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315194912.GA20259@archlinux>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8833 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=612
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803160005
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 01:19:12AM +0530, Pratik Jain wrote:
> Resending the email because it was sent only to Greg.
> 
> Context:
> In my previous patch, I had removed an extra newline
> at the end of the code.
> 
> My Reply:
> It was unintentional, but does it violate any coding or
> other standard?
> 

No, but don't do random unrelated changes.

regards,
dan carpenter
