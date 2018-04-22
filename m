Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3494735-1524430678-2-12151910003450928554
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524430678; b=YLxIwaea81Ykd2IdC0S7gWGhurbiQclM5LxxjlwJxK9NfpGwC6
    9v1kYIHqw6qve4Nr8kbHtF7EMI2WTfYdy3lW11E6FI/lRR21oUc1gPOHjXUcTcSo
    8aTwXMxUE5p9jUPcGNGo4kENati/lSWMsdOLoRenUPBul+5Hj9iJNrTDTupD1fPD
    rsrbDAe5mRf3Z11t4JHhi5KPxtyBICeZzVQJH2lykeyIF2ENDQQCJNLN3a9p7fi0
    qmBYKs/XH7iyWt6Qs4aKV0dv0T1iSqiOo5bGSWPuT9QknUyGxpb89iCvojktujTa
    6fUVZh0ZIOPp9DIQlGZVcz9MaiyVy0ibUKqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1524430678; bh=7WZ+uLClQ3
    nA9YHiXEVEvLsvHhnoJdRwN3VNDt6kBkY=; b=onS2TRakDKDvzbdeaXNJu6nGtE
    rj7pWXqfA9H1myxRTJBBw5FLvW2BlepDOgXS2kdmJlyTB6fFC4Hu4mqzwtP5b7DR
    622imi0N3G1Bu7gY6SHPqhHdg0rGM3b1zqabjQQ6cwIhENCndoRMjfmRvFXeUtBW
    BHTmBxON7hBacgkejfRXrlsbNq3rG7ao36eYy7Hz1cX0wvjBYGy80oEKSJqbmvIh
    9nKsJWx2xLhy55RsZvRDsfYxLI5cMzkcgqPUABf5zjHTYJ6BsXP0Qiieyu+iIwVj
    DZtxgAi+f6u00dQFPiv2z6NFVaNcBJgxf+vOJfYVuwGJGrhxxPztETG+abnw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLu+maAUb8uitf1/zACB7L/40yGlnRnyxBEkMcjxv9IxTfbF3thSQuG6axak7iVJ17OZeFEkm0USThFrAdzVxCR4Y3aRHZbQ4XTpfw4XqI9ksJstA/Fu
    P/MVjxBYKHRWU6VqHDG1tVg/PvoqJ3XphEebin1o5UB36BU3iHP9w5Egip+Kc46hmz7kwLnjnEctVBGT2/cpIV/z95Mqitm1OdYxcjSpeUlM/FJ1WALkwUo9
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=QRjQRLzp78EA:10 a=kj9zAlcOel0A:10
    a=Kd1tUaAdevIA:10 a=X3a0BiUdAAAA:8 a=QyXUC8HyAAAA:8 a=_jlGtV7tAAAA:8
    a=VwQbUJbxAAAA:8 a=flUdTdz3Z255RKVSMKoA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=aWu3muFgq6otJbhCXpL5:22 a=nlm17XC03S6CtCLSeiRr:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753587AbeDVU5o convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Sun, 22 Apr 2018 16:57:44 -0400
Received: from mail1.bemta5.messagelabs.com ([195.245.231.138]:60597 "EHLO
        mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753537AbeDVU5n (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sun, 22 Apr 2018 16:57:43 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRWlGSWpSXmKPExsUSt3Opsa7L9zt
  RBit2qVk0L17PZvHm+HQmi67VO1ksrh3rZbK4vGsOm8Xn3iOMFouWtTJbPFl4hsni9O4SB06P
  Tas62TzmnQz02D93DbvHxnc7mDze77vK5rHzewO7x+dNcgHsUayZeUn5FQmsGQ8/TmYpWMVec
  am1haWBsZuti5GLQ0hgKaNE999NrF2MnBxsAhYSk088AEpwcIgIZEhsPWQBUsMssJRZ4v6yP8
  wgNcIC3hJbf85iB7FFBHwkDr35xwhRbyWx/rISSJhFQFXi2PMmFpAwr0CAxKXNDhCrTjJKLOv
  bzwRSwymgL9H7ahYjiM0oICvxpXE12HhmAXGJW0/mg9VICAhILNlznhnCFpV4+fgfK4StILGl
  rx/Ktpd4fe8d2C4JoJl9jcUQYUOJVdMOsEDY5hJ7/zUyQozXkViw+xMbhK0tsWzha7DxvAKCE
  idnPmGZwCg+C8kVs5C0zELSMgtJywJGllWMGsWpRWWpRbpGFnpJRZnpGSW5iZk5uoYGpnq5qc
  XFiempOYlJxXrJ+bmbGIERXs/AwLiDsW+V3yFGSQ4mJVHe4KxbUUJ8SfkplRmJxRnxRaU5qcW
  HGGU4OJQkeC2+3YkSEixKTU+tSMvMAaYamLQEB4+SCK8TSJq3uCAxtzgzHSJ1ilFRSpxXHCQh
  AJLIKM2Da4Olt0uMslLCvIwMDAxCPAWpRbmZJajyrxjFORiVhHlDQabwZOaVwE1/BbSYCWhxh
  yTY4pJEhJRUA2NPEauU+L6/oak+rXGnTm1gd2xew2drs+L7TE6dTyt/3an5Lcz+/rVMqEQRp9
  71cAEZd0s94dnsLqqalqHuf8pYD3uY3DA1uG9+fs27UpWdLZc3MDsE5Zz0UD3v6bHN7HTNy3D
  f9ftz6jT9PHv/zDZ+Ib704DphlutPP+YpJqt8iGh6evVZmhJLcUaioRZzUXEiAEIyDZxqAwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-3.tower-180.messagelabs.com!1524430660!111730521!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH v7 1/6] typec: tcpm: Add core support for sink side PPS
Thread-Topic: [PATCH v7 1/6] typec: tcpm: Add core support for sink side PPS
Thread-Index: AQHTwo9uuL+EwiEdW0SU7JmHmFIfzqQM7/QAgACCyOA=
Date: Sun, 22 Apr 2018 20:57:32 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1E6AAD@SW-EX-MBX01.diasemi.com>
References: <cover.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
 <daf72dd237653e55c0485e930108c19a4996aa4f.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
 <20180422140508.GA21446@kroah.com>
In-Reply-To: <20180422140508.GA21446@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.35.233]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 22/04/2018 15:08:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 22 April 2018 15:05, Greg Kroah-Hartman wrote:

> On Fri, Mar 23, 2018 at 10:12:20AM +0000, Adam Thomson wrote:
> > This commit adds code to handle requesting of PPS APDOs. Switching
> > between standard PDOs and APDOs, and re-requesting an APDO to
> > modify operating voltage/current will be triggered by an
> > external call into TCPM.
> >
> > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/usb/typec/tcpm.c | 517
> ++++++++++++++++++++++++++++++++++++++++++++++-
> >  include/linux/usb/pd.h   |   4 +-
> >  include/linux/usb/tcpm.h |   1 +
> >  3 files changed, 509 insertions(+), 13 deletions(-)
> 
> This patch adds build warnings to the tree, so I can't take it, sorry.
> Please fix up and resend.

No problem. Sorry for that. Will take a look and resolve the warnings.
