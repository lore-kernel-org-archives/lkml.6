Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-490216-1525254167-2-12402120552235056632
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525254166; b=G0SgP69/rPnzOgCgcCdheqTILWYM/9YdwXKVvvsAHXVo45+CuW
    3BvyBjXs23Q+CkkIom553o8ggAmnFwZ/NJlBjOAMPTtI4TzE4aFkUAtJcUyBtAcL
    v+47WSqhe+vZWktEXeakxWt3/COpZgRjrzKY64b8bZifM7684GINAvPEyZSI4h5M
    PtoLq2LL8KybtxTobmsaW1s1//nUc/a9nuJSGmQlPhiv6cToIg3z3RVAqGrBuFIj
    tUmVQ7Y4b4i9ogXjOawidq+x2YeCnRoa4UTMdOye9oml8uzvbBDB7Td5fL4T7yzd
    0rwVZGxC+PD26sVwxhhNZib0YEorwzmgpniA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525254166; bh=UWSwt
    BDED2MVN9uOv4pFYOY4gkCCLTdzwvsbWbNiUJs=; b=in1p52D0otmtinIOzvbWq
    aCPM2CdA7aH7bVg31k74WiG803sMnvhqJO7LOUJdNjUtwJckM8/We+UoBEDLipJG
    Mmp3mmrVIdtuy69xCrEjvYko+WVspSPB5BzhXQkeNMCJeecPX8RCWNmeB3GV54BU
    b0ZmVE6kaif+u4OsoikIcD/RGiE1VSL0LvPkktQVES1gOD2MCwod6gHUy4GxA01E
    bux5u5jNdrOvMHqY6U00dMwO1SVLr/Mqf+wG13W34yIk1sQ8qPlwgSz3gEuY5Jtd
    4XCd/f4TBBa9txclm5mPpNZpSl/XmZFKRzKGSKg4v0asxwoE8YoBdOgNyH/+KK0I
    g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=microchip.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=microchip.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLVm/x7X7uffy5autZsluorx5FylYUK1uo4uuo9c7mcIkM0t3DIVdq8fleeJLsf5rT5nopgPN00gQlb0I+axBVcUIvfWG7fm3/DCkeTUhx04tMANnm7N
    jn9fjj+vZjhKTAj/mXojTRgM3OKVc1TXImcyWOhGlmN3SlbYZeoEO20GUfOUkROht7dM0azROyqH8uVsgeIQURXMgmwRFPGcVxydir9zQD+Dxd7m2aXLpqks
    dISTYU9elM4hCRxLhs36+g==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yPCof4ZbAAAA:8 a=DDOyTI_5AAAA:8
    a=Sm64sKN7g9hzAlDLMIAA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-IronPort-AV: E=Sophos;i="5.49,354,1520924400"; d="scan'208";a="13460973"
Date: Wed, 2 May 2018 15:12:29 +0530
From: Ajay Singh <ajay.kathat@microchip.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] staging: wilc1000: fix infinite loop and out-of-bounds
 access
Message-ID: <20180502151229.4be29ec8@ajaysk-VirtualBox>
In-Reply-To: <20180502083935.uw4mxvcgnpayv3h3@mwanda>
References: <20180430125040.GA19050@embeddedor.com>
 <20180430195916.596a93eb@ajaysk-VirtualBox>
 <20180430152321.7pq4ol2ed7tzsrl4@mwanda>
 <20180502111735.5a2c6faa@ajaysk-VirtualBox>
 <20180502083935.uw4mxvcgnpayv3h3@mwanda>
Organization: Microchip Technology
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
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
Cc: devel@driverdev.osuosl.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ganesh
 Krishna <ganesh.krishna@microchip.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2 May 2018 11:39:36 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> We're mainly discussing readability, right?
> 
> To me when people use "int" that tells me as a reader that we don't
> need to think about the type.  It's going to be a small number.
> 
> Say you have data which the user can control, then it's super
> important to focus on the data types.  We don't focus on it
> enough.  There is some kind of idea that good developers should
> just be super focused on everything all the time, but I don't think
> humans can do it.  So to me it's useful when the author tells me,
> "This an int type.  It's fine. This is not critical."
> 
> If you make request->n_ssids a u8 or u16, that isn't going to save
> any memory because the struct is padded.  You'd also need to audit
> a bunch of code to make sure that we don't overflow the u16.  If
> you wanted to overflow the int, you'd need to allocate several gigs
> of memory but kmalloc() is capped at KMALLOC_MAX_SIZE (4MB) so
> that's not possible. How many of these structs do we allocate?  Is
> it really worth optimizing the heck out of it?
> 
> There are times where want to be very deliberate with our types
> because we're dealing the large numbers, or user data or fast
> paths.  But there are other times where int is fine...
> 

As in this case, its fine to be of 'int' type.
So we can retain the current data type('int') for 'i' and 'slot_id'. 
Thank you for sharing your insights,it was very helpful.

Regards,
Ajay
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
