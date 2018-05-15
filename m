Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2582198-1526386925-2-4319734043226188815
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526386924; b=QnBYxlYhpkgACDaFBomBABWQxrKQTesQXKYS4N25j4I4y1E+dy
    k0eUaZOWnx9M5Fpv3O2iK6w9Rz6WN+DFtlOftm1zY7q6yKfDdS+Y3piSQtgpKaaC
    /mWaHJV4CliPlRSPDENLIwXMBHrx+gzGmH9Au2Aadm6+o5ElvkZZsmROZLG17Uju
    hQn1MR/t6XboSgPqTrIPaeM8/bJU2omlUM+eyE7BcChyfqSO5feFy5dOM3WUhcut
    tEOcQoENc5jcxfZuQcydtFdj4R91q5Uaw5SkX0LUXbtLKcVfAMstkdlZerLjWGNj
    ql4zn1RRP7kFw6VDXuCVZ7En7M4HVmbLUvWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526386924; bh=UONy/
    XgQiPg+nlZEh84VrktVJk0q7VlyEQHVWYoo6Lk=; b=LcSNdwOzZrHoN9KuytsPC
    8H6nzbwRdOMqXc5iWdfHqv3+bCGybDewi0wRv33IL0Bh7SEjO53VBnSKrrnG5nJQ
    ZifTzvfUKaLoy6c9IAhMlRkwQkBoLB5brBKbs6wVCVxRVP3bnLnftc5WvUTbBjb/
    xKxZ3ps2IUgqQKiKo7ub0w6HRzYG4rzAtyqmsPCYELd4gqY9KOKN91EJ1ApbBSyU
    vBdq8TdgG7EG01FZ9Q6oDUugVQFy4x6bpoMvUwwdBt9Tc5MWNPG5Xrb3KpKJivlT
    BBSgqQvNSp6xrwd1LSsx6T6a+QNtomV3YS20efW12oAi9VEK0SnZb+b9RddfC04p
    A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=TcbnsdE5 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=oracle.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=TcbnsdE5 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=oracle.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKdNUpzAYOd8gBtfsy5SH594LjkcIb4P5tAEhhz41Tprqja3+Nk4JTayAHAw1l1BXFqp/6axF2zcczHH59aMtm2zFVIiGWusFHEE39px7BuPu6mQ9HbC
    tArl52aHuunzjLVpE8eBbUFI9Z5NNd/Tph3GuHw5wAy/zipO9rv8AKh4qnHE1zbQr67zB4HQdo2gxpzrLJK9vWsDy/6C4ocy3eLvDE10ekBH6jqFyGCjM3LH
    iUYju0/hlm56O6Kg6EypMw==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=DDOyTI_5AAAA:8
    a=QQbeqM0vQmm7JZRNBekA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 15 May 2018 15:21:39 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: enable VMBus protocol version 5.0
Message-ID: <20180515122139.x6xmxol4iutaqys6@mwanda>
References: <20180512093033.12325-1-kys@linuxonhyperv.com>
 <20180513102409.4adc5200@xeon-e3>
 <KL1P15301MB00063E97D759B64F1CEC046CBF9C0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20180514111755.371d1d46@xeon-e3>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180514111755.371d1d46@xeon-e3>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8893
 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805150129
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
Cc: "olaf@aepfle.de" <olaf@aepfle.de>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "kys@linuxonhyperv.com" <kys@linuxonhyperv.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 "apw@canonical.com" <apw@canonical.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 11:17:55AM -0700, Stephen Hemminger wrote:
> On Mon, 14 May 2018 18:14:15 +0000
> Dexuan Cui <decui@microsoft.com> wrote:
> 
> > > From: devel <driverdev-devel-bounces@linuxdriverproject.org> On Behalf Of
> > > Stephen Hemminger
> > > Sent: Sunday, May 13, 2018 10:24  
> > > > ...
> > > > @@ -372,6 +400,18 @@ int vmbus_post_msg(void *buffer, size_t buflen,  
> > > bool can_sleep)  
> > > > ...
> > > > +			hdr = (struct vmbus_channel_message_header *)buffer;  
> > > 
> > > Hate to pick o the details, but buffer is void * so cast is not necessary here.  
> > 
> > Yes, it's unnecessary in C, though it's necessary in C++.
> > 
> > I found the patch went into char-misc 4 hours ago, so it looks we may
> > as well leave it as is. IMHO an explicit cast is not a bad thing. :-)
> > 
> > Thanks,
> > -- Dexuan
> 
> Kernel developers like to be concise. In fact there is a smatch script that perodically
> gets run and more cleanup patches get sent.

It's a Coccinelle script, not Smatch.  Coccinelle generates patches
automatically so it's a better tool for cleanup than Smatch.

I would generate a lot more Smatch information if there was a way to
integrate it easily into a code editor.  For example, we could highlight
unecessary casts or pointer dereferences where Smatch wasn't 100% sure
if it was correct.  Or you could hover over function name to see what
resources it allocates.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
