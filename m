Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2259651-1526369959-2-6877486492568587654
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526369958; b=ZsiXB7xBaeM0pztPSaV3Iik7A+kphMc/5ciU9pshst0b9JaZB5
    P63Kmeb0YWknTvMFXfemrx4sIwwoEwztKY+JSbi19mpSvOQEuerAoSg39JQYV1pd
    bx6D+gt39QqfFP8wOlqZbo+emoHtN6rT9ujuG4hm3MjUaHx+wCR4osOB2SvrtXvv
    8XCQGb+69NrK6zOuWkwo1N9CGJaCbQX6A+TNI+3enZq+HTZz080fvcRqIFBPBb7f
    BtP33AkP+wu74brjKZVc9Rrd83hBTVhu1jskE6rTgOzKjXEvcpCriD8BwZXDcQXq
    GON07SjS7WNKTc3EJ4MhTGJA63FqT0gchEWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526369958; bh=mqAyh
    CIP2+m0A1r//QqJOpu7bF38r1WmCT3Aex8opLk=; b=G7FAsj0/X2hvHFODpfuRt
    FnwwZDBzcfUISokFoOSHz/VuU4fORBkKbiLfn9PcPhtM7WQPt/gl4TRT7PlGnX78
    nldyTLoaJsLnvb5rRNF7IzoYNreSkQi3u/4UH6v7aE+S2NrI1ebbPrUd/Gp4DFIP
    PTi1GrgaJoKuj/wi7FTuw+dpcTrD7bEZ+Z8F76sH7qMtMJqE2Sn0pbFFTvjmjOtn
    4YGYaK0rjjlCmqkdB1u650z3hODyVFcTS0lRKJzjrHdES3kt82+nePuzQe7Esdhw
    0McZ9nUcSmE9505L9irBb8gbxqiEy/NbbZa3en+C9W5s9Mpc0N53Yp2E/k1iHGbu
    w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=Vuy98V+M x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linuxfoundation.org
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-80 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=Vuy98V+M x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxfoundation.org
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-80 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfICVQEB4J+bsqSxzIH7kA8LxvdVaiIkEQrFtKzkA/+QKuYT3uPaTkuAzZtSmFxF83r1opxKHr/S/tDYksabdhhuvCEiZ4i6hhKEXnS1I6lFFe2wAsexA
    6asGt9PL3aAi8QLNPzd9eWYuyBEBeo7u+uWJZl7n+6Tv6sYerZYsm8F2hUvGUdU0NXRGhHwb4do+ESHvmW+UVg+uYVxVWMyW+VB6c/pNCEmohzWbgfCrU5k8
    qDiHltujzM7sYG+LPMjAwA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=DDOyTI_5AAAA:8
    a=YUMXEJm6yEDlSm408OAA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 15 May 2018 09:38:56 +0200
From: "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>
To: Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: Removed an unnecessary cast from
 void *
Message-ID: <20180515073856.GB29923@kroah.com>
References: <SG2P15301MB00156C41A4CBCFCC94EB8061BF930@SG2P15301MB0015.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <SG2P15301MB00156C41A4CBCFCC94EB8061BF930@SG2P15301MB0015.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.9.5 (2018-04-13)
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
Cc: "'driverdev-devel@linuxdriverproject.org'"
 <driverdev-devel@linuxdriverproject.org>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 12:25:01AM +0000, Dexuan Cui wrote:
> 
> In C, we don't need such a cast.
> 
> Fixes: ae20b254306a ("Drivers: hv: vmbus: enable VMBus protocol version 5.0")
> Reported-by: Stephen Hemminger <sthemmin@microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> ---
> 
> Thanks Stephen Hemminger for pointing this out!
> 
> So far, ae20b254306a ("Drivers: hv: vmbus: enable VMBus protocol version 5.0") only
> appears in the char-misc tree's char-misc-testing and char-misc-next branches. If 
> possible, please merge both patches into one.

I can not rebase/merge patches in public branches, sorry, so I'll just
apply this one.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
