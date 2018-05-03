Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2569529-1525355362-5-7131795434811461348
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='COM', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525355361; b=fSCX5HKM6155nx82uPgnbKOv4C+LtppslO7wdrwmj5ZYr9Ty0y
    1Xj33QtKGclC5OVc27Ur28NcnkwbffBwnAuUdqmiix9DqRzKiP1ydWKGo4qJnAVh
    EyuSjWJVBEPzdl4fpGgphh0oMtQFyDhOmBTouiBDpw/QF17mimRX2f23CI0LNQmb
    NjzOPnp/DgRljpZYFhPP26MoQflHsGzdLC7JD6zRJOByZtQNz3MRcqRur/jyGfid
    SuUTsQnkbc4oJBmmggA1npShSL1iNAgzAhaUFilQlss5sbMx/Q+WXmVIptIr34WI
    STo/5bBTPUKj/vdjUUCBxCUMnoqTBFfYLapw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525355361; bh=7sj18
    LNFWA7BI6BXlclpVv6cMyihKNSYzFCBzqE5boY=; b=Qb6HH2PrPdVqZAcRouVJE
    dj2xmzYHHSSIkvD3n4ECTPNH4nfFe0ZY3/QaJPjIQB0X4zWCJhKaME+jReHfut1S
    +zPSntrJRREXK03cYpbIUo73LNggzEDXXKkqB0LK7Cc/Glf8dZPoewem5GBSMPh9
    lnxpgzqZyebFkdB37CCjEAlzsR/O+3tPW5+YrfOpdUXIzP/2ke954H+axLa18wBY
    I+6PpdxZADAfDcBcSVLu6Qk8uzwGxs1iHPXLkM76LTIzKZHFUhOe6wj5XX/BNEy3
    87TxoR+EYWS3sp6J6manRKTehBjFEA1W5PVp5lskljLP6K7/sXX4ZW7t4OhUccSM
    w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=aculab.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=aculab.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=aculab.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=aculab.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBBds8JzRy4c+n8gTdfE65ysAO9RF1u/5Z55m8AJ7WxEx9zSDksKiQPR1NkwMv2Bn1mCTYx2yUCOEXxLU/Pk4MBSwWVtTNs4QyqlfqNny/yAOZa3IcJu
    Tg9IgF6mBE+HeXPDFd/3XP7+3vFIyFUPfdHoIW77+pMDmGMVwsZ64A5c8aN/raqaGZ46OcnRH5mJN9M8ZJBu4zSIRmW/oMnYY9MsfB+sRM0v8MOWA//pXFUc
    0Usa+oIiNsMCPoYypEIstQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=tAi6d84QYPMA:10 a=kj9zAlcOel0A:10
    a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=lB0dNpNiAAAA:8 a=DDOyTI_5AAAA:8 a=-6R6bff6zvJo12sUjG8A:9 a=CjuIK1q_8ugA:10
    a=c-ZiYqmG3AbHTdtsH08C:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: David Laight <David.Laight@ACULAB.COM>
To: 'James Simmons' <jsimmons@infradead.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "devel@driverdev.osuosl.org"
 <devel@driverdev.osuosl.org>, Andreas Dilger <andreas.dilger@intel.com>,
 "Oleg Drokin" <oleg.drokin@intel.com>, Lai Siyao <lai.siyao@intel.com>,
 "Jinshan Xiong" <jinshan.xiong@intel.com>, NeilBrown <neilb@suse.com>
Subject: RE: [PATCH 1/4] staging: lustre: obdclass: change spinlock of key to
 rwlock
Thread-Topic: [PATCH 1/4] staging: lustre: obdclass: change spinlock of key to
 rwlock
Thread-Index: AQHT4kKj75feMa9hUUOW7d3VlFt3tKQeBXug
Date: Thu, 3 May 2018 13:50:07 +0000
Message-ID: <a3594bd7c393418c8fda5150a075ff1a@AcuMS.aculab.com>
References: <1525285308-15347-1-git-send-email-jsimmons@infradead.org>
 <1525285308-15347-2-git-send-email-jsimmons@infradead.org>
In-Reply-To: <1525285308-15347-2-git-send-email-jsimmons@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Gu Zheng <gzheng@ddn.com>, Li Xi <lixi@ddn.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lustre
 Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: James Simmons
> Sent: 02 May 2018 19:22
> From: Li Xi <lixi@ddn.com>
> 
> Most of the time, keys are never changed. So rwlock might be
> better for the concurrency of key read.

OTOH unless there is contention on the spin lock during reads the
additional cost of a rwlock (probably double that of a spinlock)
will hurt performance.

...
> -	spin_lock(&lu_keys_guard);
> +	read_lock(&lu_keys_guard);
>  	atomic_inc(&lu_key_initing_cnt);
> -	spin_unlock(&lu_keys_guard);
> +	read_unlock(&lu_keys_guard);

WTF, seems unlikely that you need to hold any kind of lock
over an atomic_inc().

If this is just ensuring that no code holds the lock then
it would need to request the write_lock().
(and would need a comment)

	David

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
