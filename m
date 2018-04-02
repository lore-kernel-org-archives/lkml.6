Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2791776-1522669559-2-9388481743754120313
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522669558; b=Ev+KK3SIezQF5kZNrg7LZbE2e11/mQLUVAmjxtiAaXgTVl+oPV
    9NwfkO9kJgldll5RV3/EkuQIzU81wZuOuKO7zCkYiOcVggf94AF8f8oS1K2ASRyF
    If683lDlwfK7vtN/EjbnDY5l1WmcqAd8FRImvgdeK+4OfhBgC7Qo5wNPIPiWwCpo
    JnJLsYKd2Ijcoh1JznCj8kmswrE9MUv/6CbatcP6urOJkf65Sbn/64Gk2rehnGnf
    1CQ8xK0cDYvITSOK9NPV83SPgRoyPFnDWcU5yaAj5jdQuOhCwRyltbYXJO76iBBP
    oRfUOSKH74DGt12G4EbCzoNi7ug3Jwta3RgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522669558; bh=b9coQ
    FFaa6G9iYXndzcnCuf/AkPYAgqRuE6wJtruQYc=; b=fvs/tg7BkErJfwLgQmUwy
    qRL26OjAZ23gJnB/djOtarN2rLFRXJkT2he8ly8cBeVSxYMypdFXrI0U0rIAshLF
    J5QGD+tJNF5khets/2xWWLutducR/CsJ9dEXPbEHSvbCGDPqqhonHIEyD7glkBBs
    NoMgYb+a8cuKRx7WttWLqiU/AlkT+sKBwn/gUHGNLdBrxnhm4BoexVERaSsBD2Hb
    jPu0EG2BkFLezpyxNbD/nRrA3GXiGgZLA7xAjuAUUlCAt5e3Y3AzLyhPg5jQvJP4
    0KCFlZwN5A+w/lH/RcwaN8Q2d662yiTP28DYxoOZbKLYG4goONc6vlC+vmV6yLyQ
    w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=RqljAFpM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=RqljAFpM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBjLOgcafSKbiVTzKvgaX4uylmCsemD1bW2dCgWFKCFAWYtauIjploPYPANAt4OE1M+Jk3qaf9llgl1n92YMqzVynV3tz2o3T9/txWEbUv/eTMGotLWF
    99NIx8qJxKDT1vAokWduAxXdS38yk9Z5jMHBQuRMsATIe55wruXhiGNFMUMU/81LPx8THZzdVvyPZ95GHm7L9vV5nhDJjR9pi+jC0feBI5WZGkNLYVOda/R5
    WX4cT6feqwN0z17EuHOS1w==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=sIX3fyf00tJzIfDfYj0A:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 2 Apr 2018 14:45:39 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 01/75] staging: ks7010: Use the ARRAY_SIZE() macro to
 calculate array sizes.
Message-ID: <20180402114538.slvlts3djle4mqev@mwanda>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
 <1522478173.2210.53.camel@perches.com>
 <20180331084150.e6uottdsdagtywbp@mwanda>
 <1522505573.11653.1.camel@perches.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1522505573.11653.1.camel@perches.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8850
 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=579
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804020127
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

On Sat, Mar 31, 2018 at 07:12:53AM -0700, Joe Perches wrote:
> On Sat, 2018-03-31 at 11:41 +0300, Dan Carpenter wrote:
> > On Fri, Mar 30, 2018 at 11:36:13PM -0700, Joe Perches wrote:
> > > On Fri, 2018-03-30 at 23:07 -0700, Quytelda Kahja wrote:
> > > > This macro, provided in 'linux/kernel.h', will calculate the size
> > > > more succinctly than a division operation.
> > > 
> > > It's nice that you send patches, but please try to send a
> > > cover letter with your patch series.
> > > 
> > 
> > There are obviously times when a cover letter is required but what's the
> > point of that for this particular series?
> 
> practice
> 

It really pisses me off to see patch submitters get assign busy work
for no reason.  This is not school and these are not your students.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
