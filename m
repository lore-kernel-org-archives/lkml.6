Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3801236-1518001458-2-2388501014472165987
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
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
    t=1518001457; b=hesz5zoEdMniq82ZNAZDM8wU1er5ryGiwvReyFW88GY6FQ7
    bHoJcxS57znNHP4TyAEupWD7TTbxgYeLnXRzQzfoa+DVm7XDM+GA3iGzH8otaKiu
    zSBeCTtabyiPiV0nSiIDzlOM8zH44tEbsBB3qCn9vL9lqfb5SzEn9N6JpzUdXS9p
    t0UCUaAewfCVPJpgxOTCAB5T8pvaiwgCDXEoWfjXdTs+KBaCq0ShsdWVVzU3MDJ8
    uzpIeZAx08sP4TU/UthM5ZStEBawMYws2xqrpPADb9mId025RBHi05/xoDZLH3hr
    TzcyoO+A3sWf2rbl8u2fGINJxEoK0jw0umfLjEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518001457; bh=e
    QknwRcGs1tdxPYkL4dLtRrXGuzteLMHQOEpxnJ9Spg=; b=U+eLRk3OkWpjafws0
    VAKAPnGOmOMo+vVAr2oE1mGOhZHIZwRGaI/iXJcvBBchwniPXR1+goCyhmuRrVaM
    P03pQGHLBs3iKBLY2D6BPSZUuHt8KzxqwLCcwu+Ok8yx/UtOpytBXFUxU/pzKN8A
    yUiMRyU1kq0fqYJXK+7ygZLCKI+iVtnwk5svCjlvq+yo1Ko26nTUNWLGawGxwUh9
    1hxmWUFD8bdo8GUt1TW5YBezyBpFrKnw/WjNEYxjAD2Wlm/A1239BoP024TgX6kP
    WSLqWiGw/l6oh40RrrA1MHC9iu1F+szuJGimHLi9hVmKSCrIbQHMYY79Kc3eTdc3
    EW0Jg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=n09NdCwm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=n09NdCwm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 7 Feb 2018 13:58:53 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Kangmin Park <l4stpr0gr4m@gmail.com>
Subject: Re: [PATCH] Resolve RF Type mismatch
Message-ID: <20180207105853.2mul5qev4btg773i@mwanda>
References: <1517932633-7832-1-git-send-email-l4stpr0gr4m@gmail.com>
 <1517933300.2557.81.camel@hadess.net>
 <CAKW4uUzDA22u=URAaSvXT_tpEruu6i_R9VuGnX0nbu1OzM4_DA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKW4uUzDA22u=URAaSvXT_tpEruu6i_R9VuGnX0nbu1OzM4_DA@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8797
 signatures=668663
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=526
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802070140
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
Cc: devel@driverdev.osuosl.org, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, justin@jvreeland.com,
 linux-kernel@vger.kernel.org, hdegoede@redhat.com,
 Bastien Nocera <hadess@hadess.net>, joe@perches.com, davem@davemloft.net,
 Larry.Finger@lwfinger.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Also the patch prefix is wrong in the email subject.  It should say,

[PATCH] staging: rtl8723bs: Resolve RF Type mismatch

On Wed, Feb 07, 2018 at 01:31:48AM +0900, Kangmin Park wrote:
> Oops, Sorry for being stupid cuz of first time to use git email.

No problem.  We were all newbies once.  Send the email to yourself first
and try applying it with `git am`, then review the patch with
`git log -p`.

> RF_TYPE and ODM_RF_TYPE on staging/rtl8723bs is different from
> staging/rtlwifi 's - updated from v 4.14 -
> So, I try to update code on staging/rtl8723bs in comparison with
> staging/rtlwifi.
> commit message is "Update rf_type and odm_rf_type in comparison with
> drivers/staging/rtlwifi"

It needs a longer commit message than this.  Also it probably needs to
be tested.  I tried for about 10 seconds to find which patch you were
referring that updated staging/rtlwifi but I gave up.  What is the git
hash and subject?

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
