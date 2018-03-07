Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2943591-1520420538-2-8664942851166860584
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520420538; b=nPmvCNj3zVZlUYpE1qFYFbjOyUX8i/ZBGiFgktpkp/E9gdi
    AFBg3zySPLZ7A2oiWrKq6tUipLLmuLp833ufjzUPU+dh75I0YRloTf117BV8dZ8A
    RFDjsGlwkWHFxLPaJcsOwb82damBhZdSrhqz8Z84ml3F3H+tQsodYD0V7jQ1STak
    fd9E3QfitmFD9DVGcz7m4W8/LDMSSMQJvaXgmj5ahg9N+fkGr3j2Gr4dgTc1n84A
    8mSy+S68lhmjKSOLKoSeD15wC0NfwaRApjqGzy+fmY1h4+G6rxCqt1p/eTYoJeQz
    neBOD9Wwho5j6c/nL8Dx8NFcTe/WjxP4g8vtyYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520420538; bh=9
    Q6mSEgh4stVvBW6GJrDVf9TG8Y08yvmI19jgI7zIVw=; b=jH3r6sfSn0cmQvqEx
    2JiGJq6O9V14Jygl1qfjw+teI5QJPUg6AcaOYrkrl54ipVBTB4Q7oqM5Wyc+vNzF
    EXswXKrQYo9CSWAh1Aj29VTHNyc2omHhBxKUyxvDSSAS0Hp+u9uA4CJD6Gj9AG/w
    HtLPm5G75o6t+D8xxjq0IMd0dW5OuDst1RtNCFQ6Q5UgJa2fnrF793dJBifqdqCS
    YEp7DCj24xnmVM52O1jkahFhWFpGVb7RwORi5wZ+aHkBm7A7hBu0NNk+XGKllDVd
    Fc7lFQhvDJ18+MsQkfMmZE566A8z91f0XrMsvlIyIXS9HroS40G2MakKeJrnIgtP
    jU4kA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=NeVZTePe x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=NeVZTePe x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 7 Mar 2018 14:01:59 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [Outreachy kernel] Re: [PATCH v3] staging: rtl8192u: Replace
 printk() with more standardize output format.
Message-ID: <20180307110159.gnetxajp4c7oz52x@mwanda>
References: <20180307103908.GA19612@seema-Inspiron-15-3567>
 <20180307104741.mdy2wa7hplfwxmb3@mwanda>
 <alpine.DEB.2.20.1803071151080.3361@hadrien>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1803071151080.3361@hadrien>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8824
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=971
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803070128
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
Cc: Arushi Singhal <arushisinghal19971997@gmail.com>,
 gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 07, 2018 at 11:52:16AM +0100, Julia Lawall wrote:
> 
> 
> On Wed, 7 Mar 2018, Dan Carpenter wrote:
> 
> > On Wed, Mar 07, 2018 at 04:09:09PM +0530, Arushi Singhal wrote:
> > > @@ -276,22 +276,22 @@ static int ieee80211_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
> > >  	keyidx = pos[3];
> > >  	if (!(keyidx & (1 << 5))) {
> > >  		if (net_ratelimit()) {
> > > -			printk(KERN_DEBUG "CCMP: received packet without ExtIV flag from %pM\n",
> > > -				hdr->addr2);
> > > +			netdev_dbg(skb->dev, "CCMP: received packet without ExtIV flag from %pM\n",
> > > +				   hdr->addr2);
> > >  		}
> >
> > I'm sorry.  I really hate to do this to you...  But the right thing here
> > is to use net_dbg_ratelimited() but get rid of the if (net_ratelimit())
> > check.  So it looks like this:
> >
> > 	if (!(keyidx & (1 << 5))) {
> > 		net_dbg_ratelimited(skb->dev,
> > 				    "CCMP: received packet without ExtIV flag from %pM\n",
> > 				    hdr->addr2);
> > 	}
> >
> > Sorry again, when I looked at it before I just replied what my fast
> > thinking lizard brain said instead of taking time to look at what I was
> > saying.
> 
> I don't think that net_dbg_ratelimited wants a skb->dev argument.  The
> various definitions in include/linux/net.h just have fmt as the first
> argument.
>

Ah....  That's fine then.  Don't worry about it.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
