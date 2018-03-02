Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1073259-1519981534-3-1358604604853552268
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519981534; b=PJALQaXbMk8ItvF11Gr6uRLVR15y4jtyLB3HGwt87EyDV+U
    r0pbNay5TJXFv3A5d57HpxS/mMaRW0Arig5BBT6mqk5rSww4/sUErBCVOJTVFZus
    XtJLTM1bWUxRpVb1Lwc6u44J63HAqNZjdN3zq88Y3ckTDFTaDIfCs37ht/geqM2C
    neq5l3k+/nznJnGX+hu1CKaw0DsvfLKEwlQsRF7BDzKIMcq/ozBt8NkDJv/jalqQ
    fORUmLAA4kVpqeqLsNTL6uvUFqVgbchSdN8IP5n1x4xXo8H6G1bxqLOtdCh+GpVs
    cGO12SK1nK/BRFKyr299bY+4m4KUthxwhi5xU+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519981534; bh=G
    mc1P0PRi6m3D5mz2Fo0i3H++zAwyXTRAXbw81vu0Uw=; b=c+V91e33DzrhaYJ0F
    BYw6KEuVxcZeKag1H0v8pkZ9GPPPwJpEUhnHdzCevxIyCRwW+oyxRB8EUQBQTybH
    rbM4//vav0iHQ5+jXvmvjaFJHmEN4oSq4JELD7fVyOdhV/MU96ccgrI9oipKmnrF
    j2txg3TwzMawz9Jj6GEb+/5B7l0TqBUhRxTpWTO81EnZAZubbNs4nQDaXsFqAEH1
    ifDOtdZSHxjdrS2goBibq/zn9uMzmbEEwH59+trUVCwKFU2MkhulGS/ngYN38Z/+
    dhgYeDDHtO1MzMcYEEFOPmbEEcUBMQcardxLCb/nBSMZqap1Lh7CxL5bC3qCH5JG
    bpvIg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=l8LgMVuf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=l8LgMVuf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 2 Mar 2018 12:05:03 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [PATCH 3/5] staging: ks7010: Factor out repeated code into
 function 'ks_wlan_cap()'.
Message-ID: <20180302090503.2zgnzhy5dtolmk3n@mwanda>
References: <20180301051911.1314-1-quytelda@tamalin.org>
 <20180301051911.1314-3-quytelda@tamalin.org>
 <20180301063721.GD4059@eros>
 <20180301111500.lxge4yqfyi2najt6@mwanda>
 <20180301205436.GE4059@eros>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180301205436.GE4059@eros>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8819
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=648
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803020106
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
Cc: devel@driverdev.osuosl.org, wsa@the-dreams.de, gregkh@linuxfoundation.org,
 driverdev-devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
 Quytelda Kahja <quytelda@tamalin.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There are so many rules for kernel developers to deal with.  Is it worse
to go over the 80 character limit or align the parameters properly?  Is
it OK to start the subject with a lower case letter?  I get in trouble
for using the wrong prefix but I'm the first person to patch a driver so
how on earth am I supposed to read into your @#$R@#$@#$@#$@ mind to see
what prefix you are going to want?

The imperitive thing is a good suggestion for people to think about but
it's not something that you should suggest to other people out of the
blue for no reason.  I've seen people do it for OPW and I'm like, "Eh...
I guess in that case maybe the intern will have to deal with some super
anal maintainer so they should know all the rules".  But generally,
unless the person asked you to tutor them about every single unpleasant
thing/maintainer they might have to deal then just let it be.  Otherwise
you risk becoming that unpleasant thing they have to deal with.

Don't lose track of the bigger picture which is "Can you understand the
changelog?"  There is no such thing as a perfect patch.  This patch has
a style violation which I overlooked because it just doesn't matter.

It's discouraging to be nagged at.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
