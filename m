Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4134448-1526457657-2-13308311901802144472
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526457656; b=KNFrEPosK57xy+fQI3/JWMwwDZ3fcDbv9xPNgSHtOxX0X8QNm+
    gBIchciAd6WlFM1xQdTgvYWQTBstLfuTepTRavpH9LOKJhCZssxSt40MQGFPQNLr
    pqKVC90fELb1Ynf9q7Gi8GmYn0lM19kCvgkStWQSwV2ICzSLRXHSq+liq5BSt9Yw
    e4McUEyKC98cO/YFYDgDH+0OvvfRZG1IgTKg9+lLtPmp+VpK5kkz4GUobmg/g3mq
    IUx1pmArm/6yHmg6VciZlWTilDRdxMTQzu41D5y6djYYlgjzbsKkdUtQdndW+Tps
    580qGGqGDlR0ykU4/wx2LLNoB/Da0OGwFZsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526457656; bh=TJ40X
    8c4iCD6r65Jc4R1N+8aO+dP7ic/p1mN/kc2Yj4=; b=c0EL4QlYV3/t+blCu5Wlz
    il23C0AF0iwaPSmy9B31Tt3kcRW8mwW/RpX7gD3BS4vNZXFn7mnTJltAmB45gjEh
    ATmWZaqgEESIf+HPXbfUU+Sndg7y+nIO7iW6TDzo7Srl/dB4P35s3qui2xPsarDY
    NAmf/1ps6tdF2yNAMLd8MM2j/rBfjreC59Gxa/BrJ1gaS0XV5HaxCRZeWbxPAKuN
    XBqvpWW/RQq0w6adk5n/06UT0y4sEzF0CgvHtS06VSQag7XqPc7tLSOyiAN/AErX
    FDLFZ/IC3oO46WKuapalSHT4VbQ38oRYmXRMTWHcGRAMiGe2T/IzLbZur3bkPGpS
    Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=KpRZ8kTO x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=oracle.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=KpRZ8kTO x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=oracle.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPz/f6xVkdHkru6R5tVojOPrlaCc/0jZ/Q+wMISepJ6RVqdQ9dotHymoOIF7RTDyebcFMhLOp+thdVkLxIhw7NAOy5XpNRvUExFZHFksyrWAp0L6vsmj
    6Xfc5YQus81z94pQv/r5lQHJhevDrIL7K5NAopeW+GW1aXKyTFqNnYy4gLrlFb1ICUVGAZgsj7Rp7AdRz69LQc/mpRSaiFkGBopSRbK1GWo29Zs6Nso0jRde
    BTxJ6EBJzDPR+TbKhtK6Yw==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=r9r7nowuVfkaj-vOzoUA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 16 May 2018 11:00:22 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH 4/4] staging: lustre: obdclass: change object lookup to
 no wait mode
Message-ID: <20180516080022.b4ihz7opiueobm7u@mwanda>
References: <1525285308-15347-1-git-send-email-jsimmons@infradead.org>
 <1525285308-15347-5-git-send-email-jsimmons@infradead.org>
 <20180508114500.qrtnjax4siupgv3n@mwanda>
 <alpine.LFD.2.21.1805150207500.576@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1805150207500.576@casper.infradead.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8894
 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805160082
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
Cc: devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, NeilBrown <neilb@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Oleg Drokin <oleg.drokin@intel.com>, Jinshan Xiong <jinshan.xiong@intel.com>,
 Lai Siyao <lai.siyao@intel.com>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 04:02:55PM +0100, James Simmons wrote:
> 
> > >  	/*
> > >  	 * Allocate new object. This may result in rather complicated
> > >  	 * operations, including fld queries, inode loading, etc.
> > >  	 */
> > >  	o = lu_object_alloc(env, dev, f, conf);
> > > -	if (IS_ERR(o))
> > > +	if (unlikely(IS_ERR(o)))
> > >  		return o;
> > >  
> > 
> > This is an unrelated and totally pointless.  likely/unlikely annotations
> > hurt readability, and they should only be added if it's something which
> > is going to show up in benchmarking.  lu_object_alloc() is already too
> > slow for the unlikely() to make a difference and anyway IS_ERR() has an
> > unlikely built in so it's duplicative...
> 
> Sounds like a good checkpatch case to test for :-)

The likely/unlikely annotations have their place in fast paths so a
checkpatch warning would get annoying...

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
