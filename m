Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1206538-1526321886-2-4944871553274167554
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526321885; b=fhE9nzcExnbNHSvMf5Z3NgiHzwYj6ogo5LTkqpMwAbR/77501J
    egtRoqYaBNkoROJ29FkJtm1yY2vJDf7qpMznmu7A6RfX7ETJKHxSRwVpTHJjmqCX
    I1gz7mJ4T701xdZnWDzzFStjlhbEdtNYKnuJyvb9zQ95bcQ6OvNF99eSnLKpSnae
    0Dwax78Xn6tMjYxASz94zEPhKwYkNO+IMQhUewDjFMDTuMdxTX9GCL5351csBx5G
    eHEouq57CL35DyE6rGotqkmdaP3ElOIUG9bPA655lfASTC1ubolgitu2EO8FPpS7
    OCIxjsLoZOtyilQU8T2xn7DLk/KjzZR7P0/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526321885; bh=eWFem
    eapF8khM4M3/T4kMaXfxao9qNiYf32DNtGD8ds=; b=ciykYFkyViTkOCRU+mIAG
    XLxnFo8qKtsYX9R2Q1S6nqxzha0C/Feb0Ae3jWVozj+yoHBPbdm9ZRoFQGsTxfI+
    WlbzrzYag11XEc+p7F/WAhvkLNtZW6Q0co+dUL4koAN3iRCwh6dCPhIOFOtUhm1A
    M94ye6mQZ6A2EV9Y8RpDf0HLl74DZ06s6LhT0e80Y7nEkN5D9oYDFV9ztDwgjYBL
    +ErfPsZi6zXh0YNXKhu0cFu3JCpSO+jE6R/5/8QiuXVuIQVCWHFsX7IlPxP6188X
    R5fGo6H92udWKYGj9ebp4Pstx4s/WOF8XgC8FQvp/TxediqcFDs8+iOPjGIuF9SX
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=networkplumber-org.20150623.gappssmtp.com
    header.i=@networkplumber-org.20150623.gappssmtp.com header.b=0UFSxJhB
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=networkplumber.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=Tvw5o234;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=networkplumber.org
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=networkplumber-org.20150623.gappssmtp.com
      header.i=@networkplumber-org.20150623.gappssmtp.com header.b=0UFSxJhB
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=networkplumber.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=Tvw5o234;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=networkplumber.org
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKuapmaycBOjmM3XDdf1qCmrXP7tFrxu+Z9Q5tcMzL0uzEqZ4KNT6ETbxUmtzqFW4PT17nhEbI3haTgBxVQRMoasgPfc8+M6pdsKhPWH48uIovSNz8NY
    zrY7vLFJZcM8tjqpdAC9D5Kl2bKRPXtf7n3oIdrGaiVc0yesD73EC7/y9l4c9Y/DWq45u4hHA8VMuYOyXOjdcdxXeFV1d6kYlbo0fVEEClISeBsQFFO579Lm
    iLmhfgoTjKIF2T42i0A7ww==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=DDOyTI_5AAAA:8
    a=kLSb_5vlOmzjy18_V20A:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZoS/YZrxYni65XN0s2Doq8WAS1aHMyzvDMpkUKXr6KDL1Rzh1x9s6zayzD0jtcTgVs+WK6X7g==
Date: Mon, 14 May 2018 11:17:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: enable VMBus protocol version 5.0
Message-ID: <20180514111755.371d1d46@xeon-e3>
In-Reply-To: <KL1P15301MB00063E97D759B64F1CEC046CBF9C0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <20180512093033.12325-1-kys@linuxonhyperv.com>
 <20180513102409.4adc5200@xeon-e3>
 <KL1P15301MB00063E97D759B64F1CEC046CBF9C0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
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

On Mon, 14 May 2018 18:14:15 +0000
Dexuan Cui <decui@microsoft.com> wrote:

> > From: devel <driverdev-devel-bounces@linuxdriverproject.org> On Behalf Of
> > Stephen Hemminger
> > Sent: Sunday, May 13, 2018 10:24  
> > > ...
> > > @@ -372,6 +400,18 @@ int vmbus_post_msg(void *buffer, size_t buflen,  
> > bool can_sleep)  
> > > ...
> > > +			hdr = (struct vmbus_channel_message_header *)buffer;  
> > 
> > Hate to pick o the details, but buffer is void * so cast is not necessary here.  
> 
> Yes, it's unnecessary in C, though it's necessary in C++.
> 
> I found the patch went into char-misc 4 hours ago, so it looks we may
> as well leave it as is. IMHO an explicit cast is not a bad thing. :-)
> 
> Thanks,
> -- Dexuan

Kernel developers like to be concise. In fact there is a smatch script that perodically
gets run and more cleanup patches get sent.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
