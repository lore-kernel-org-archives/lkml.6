Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4190028-1526461960-2-15614822952945597284
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526461960; b=lEmjXoUxr6WrekWaRLrz59Pvk+oPg6WvqpptTHgabU/aL0PrJu
    T/NwtnRai7NbF/ZK6l3RNoLYdARK0FEnqFMiFHxVcBrrqPUqC9LTafYWsHenfP1I
    VUn7F6eOrchEDV40h5rfrK10EWQ3hMJM6p7qw8IZdtflIwYjGJybtI8qAVYxx3kp
    IXI1w3Uyja325rvoM3ZzLc6bbF2J/67yPKmffVdXcdFCAtS3Z/KeaawkpPu2UdoG
    EdLbGTCNKzDVT7+wa6utSOt1lqbINl55LB7w25KpdLBhLWZwMJWxDlnz4AFWDdMZ
    Sx62rMd/opJPp0HwXEv3jr8sbqKMAQmCFDTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:content-id:mime-version:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:content-type:content-transfer-encoding
    :sender; s=fm2; t=1526461960; bh=89ijPisDGahsAmSNNdhbYVQUjuQgB6x
    iVopUBFUKjeE=; b=Gy9Efmao9cGWjaZDDndQqw3b0zTTehbvniOUagBGjVDwFQ+
    d64k3FLecshYFg3Z1FkYasU7DXxpRi4xKYQF97ZFtbXQZ7Dqg6RUPOWRRfQYmUAl
    okcs/Xg18OKUDm218wBVD2kf8qrVFCMni/Zq/54HGfQq4omxMdhxtqlOjvTcLDo/
    CgG+yTx5bMnBWZ1jiICizkSS+RruBS/Ov7DJ5XH29YxNfoLjz443UTUJiBHZ4uJf
    ptwe5WWUx2yAbL9x5XFY7Zz/i85SNU0kVR7HJjxzUh8Zx6G6yllx+arIU6bpiNIp
    /tKScIcXkIIeWL+s1zvWDUgK428L4w22IWNG7Pg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=intel.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=intel.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEaX5g3DnTFt9RiKq56wAO8gO3KbZFcmWByj7adozfj4jvDTo97ZYKEFhT8NlKbaiLOtWv6hd7Ppl0ztyft6Hy3G44xjIGeFYAo4DZadzNfFt5uK6bHX
    Hec0kEBW2fbi6AEUwFEIummcPoZwLIaBgBo+VWyUFoG0Zf1T2asUU/LyRxjAcxQHCVbrF4DHXTxfLLsBL4m2rOqJBGWadWylLm6alxYC68EMul6ec6eW/Mbt
    v/3yGzZ72Zo4ONFp6xrAFw==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=hkvaZapChtEA:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yPCof4ZbAAAA:8
    a=DDOyTI_5AAAA:8 a=lFw1gQO2iXAsKJXOdI0A:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400"; d="scan'208";a="51270729"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 4/4] staging: lustre: obdclass: change object lookup to
 no wait mode
Thread-Topic: [PATCH 4/4] staging: lustre: obdclass: change object lookup to
 no wait mode
Thread-Index: AQHT7OwdemUl4VD6TkCSX3ZkBHhspKQyh4qA
Date: Wed, 16 May 2018 09:12:32 +0000
Message-ID: <EDCE6E68-0B5C-4F82-B356-8D70AE5FF92A@intel.com>
References: <1525285308-15347-1-git-send-email-jsimmons@infradead.org>
 <1525285308-15347-5-git-send-email-jsimmons@infradead.org>
 <20180508114500.qrtnjax4siupgv3n@mwanda>
 <alpine.LFD.2.21.1805150207500.576@casper.infradead.org>
 <20180516080022.b4ihz7opiueobm7u@mwanda>
In-Reply-To: <20180516080022.b4ihz7opiueobm7u@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.68.233]
Content-ID: <80C2CFBAEAE0B94588A644234D0791F0@intel.com>
MIME-Version: 1.0
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
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, NeilBrown <neilb@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Drokin,
 Oleg" <oleg.drokin@intel.com>, "Siyao, Lai" <lai.siyao@intel.com>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On May 16, 2018, at 02:00, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> On Tue, May 15, 2018 at 04:02:55PM +0100, James Simmons wrote:
>> 
>>>> 	/*
>>>> 	 * Allocate new object. This may result in rather complicated
>>>> 	 * operations, including fld queries, inode loading, etc.
>>>> 	 */
>>>> 	o = lu_object_alloc(env, dev, f, conf);
>>>> -	if (IS_ERR(o))
>>>> +	if (unlikely(IS_ERR(o)))
>>>> 		return o;
>>>> 
>>> 
>>> This is an unrelated and totally pointless.  likely/unlikely annotations
>>> hurt readability, and they should only be added if it's something which
>>> is going to show up in benchmarking.  lu_object_alloc() is already too
>>> slow for the unlikely() to make a difference and anyway IS_ERR() has an
>>> unlikely built in so it's duplicative...
>> 
>> Sounds like a good checkpatch case to test for :-)
> 
> The likely/unlikely annotations have their place in fast paths so a
> checkpatch warning would get annoying...

I think James was suggesting a check for unlikely(IS_ERR()), or possibly
a check for unlikely() on something that is already unlikely() after CPP
expansion.

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation







_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
