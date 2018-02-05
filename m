Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2143866-1517826634-2-13250540573061450354
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517826633; b=srBHbZGvIQlciw26CVhCS4qpJ6mWXkWdWGpE54ODa3hT7sl
    q51jOngJjXN62/BsYoTBKnT1VXHb2P6pydfDYp5HlweCZwB2GIZozWYwlAMrIEQu
    XhunAdBPigGQ8PrdvRdT9XjBRX7NLrJiZOI5x+v7yJHjTJnFinfA5LSTBChVfHh8
    sEoKo0tNf2TqVhkOv4yDyjC+4X8cMQ72f/7Fo0aL6KwhzMbREbM3Xr4RD/CG2kR8
    omne/Qt+j7R/HXGsqBDisgT6ly6VwR45B1tZEavC+ISUgGRtyLR1PT+JmdfUAkSA
    /8XXEmk8Gfvq1OXB7jneecp6wOdupdj5vz5dJEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517826633; bh=JdP8id
    +bQTekyBGjbnCyZGaRaVWnkfH14YxGEiLWB2Y=; b=PZfh67pZkvKL7yNJLDFZ/g
    1cvxOFDO/Zckw61slU51jMgvy0gaqYhUms5kjdmrGYZGZSHjPgV+/sWKTu4xIHpe
    KIBi9lCEkxSDlVSr2BtH1vyvF/RTB13atrQfHcBle2r/RGu/A+ZevhSL1Ezn0A6O
    RMbzL0Gt8XuvNlc59MrqZHWzocLjh4Qvd1phBidhGLe49pZrmbA0r68ZfuCT7PqF
    UKpzyZ7UsQ4zs9n3dEyCvx8gWwvmBq1DuonyIeeRc0o+DNgq5opcXlmrys9lFbeK
    /qskSlh1juo1E0gslFWywG/WdahYsrcEh2715I602YIaVPGYsqFjm1Cor2mGe9nA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752312AbeBEKaS convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Mon, 5 Feb 2018 05:30:18 -0500
Received: from mail1.bemta6.messagelabs.com ([193.109.254.114]:46042 "EHLO
        mail1.bemta6.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750949AbeBEKaQ (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 5 Feb 2018 05:30:16 -0500
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRWlGSWpSXmKPExsUSt3Opsa6pUUW
  UwfHr1hbNi9ezWbw5Pp3Jomv1ThaLy7vmsFl87j3CaLFoWSuzxZOFZ5gsGhe8Z7E4vbvE4s/z
  W2wOXB47Z91l99i0qpPNY97JQI/9c9ewe7zfd5XNY+f3BnaPz5vkAtijWDPzkvIrElgzPhx6z
  1zQx1uxfOIK9gbGM1xdjFwcQgJLGSUWTFzL1sXIycEmYCEx+cQDMFtEIEti8tblTCBFzALXmS
  VWnb/PBJIQFnCTWL24A6iIA6jIXWLyaV+IeiuJ3d9+soPYLAIqEt/n/2MGsXkFAiSWrl4LFhc
  SKJLYtuY9I4jNKWAusX7NZrAaRgFZiS+Nq8FsZgFxiVtP5oOtkhAQkFiy5zwzhC0q8fLxP1YI
  W15i+7ff7BC2vcTre+9YIGx9iUePHzFC2IYSq6YdgIqbS/x7NYkJYr6OxILdn9ggbG2JZQtfQ
  90pKHFy5hOWCYzis5CcMQtJyywkLbOQtCxgZFnFqF6cWlSWWqRrqpdUlJmeUZKbmJmja2hgpp
  ebWlycmJ6ak5hUrJecn7uJERjtDECwg3H6Zf9DjJIcTEqivIIKFVFCfEn5KZUZicUZ8UWlOan
  FhxhlODiUJHj9DIFygkWp6akVaZk5wLQDk5bg4FES4XUHSfMWFyTmFmemQ6ROMepy3Hjxuo1Z
  iCUvPy9VSpyXD6RIAKQoozQPbgQsBV5ilJUS5mUEOkqIpyC1KDezBFX+FaM4B6OSMG84yBSez
  LwSuE2vgI5gAjoiMK0U5IiSRISUVANj/t6FZiXr9+Tv8f1yZJrarhdnGViCOWWEp02NWx+kla
  ct23X3ls5BjQf92xICZ8/zVuA8e2huos6dGZd5L527+aJoXlfqXvEU2S03PCP8olIyJk39YK0
  bsX79RO1JJbOXOTxfVpn2xvFe0PVHZTX3mBq2Ru7WSJ752+rYqQ2Xa7T2ua7OOHSjUImlOCPR
  UIu5qDgRAAkItXp8AwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-3.tower-194.messagelabs.com!1517826613!74022400!1
X-Originating-IP: [94.185.165.51]
X-StarScan-Received: 
X-StarScan-Version: 9.4.45; banners=-,-,-
X-VirusChecked: Checked
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC: Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        Yueyao Zhu <yueyao.zhu@gmail.com>,
        "Rui Miguel Silva" <rmfrfs@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH v4 0/7] typec: tcpm: Add sink side support for PPS
Thread-Topic: [PATCH v4 0/7] typec: tcpm: Add sink side support for PPS
Thread-Index: AQHTg+F1ZFZ4J0t7y0SWhgHa9CcG+6OMk7YAgAk7nlA=
Date: Mon, 5 Feb 2018 10:30:12 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1C119E@SW-EX-MBX01.diasemi.com>
References: <cover.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
 <20180130132504.GH14922@kuha.fi.intel.com>
In-Reply-To: <20180130132504.GH14922@kuha.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.43]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub02.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 05/02/2018 07:46:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 30 January 2018 13:25, Heikki Krogerus wrote:

> On Tue, Jan 02, 2018 at 03:50:48PM +0000, Adam Thomson wrote:
> > This patch set adds sink side support for the PPS feature introduced in the
> > USB PD 3.0 specification.
> >
> > The source PPS supply is represented using the Power Supply framework to provide
> > access and control APIs for dealing with it's operating voltage and current,
> > and switching between a standard PDO and PPS APDO operation. During standard
> PDO
> > operation the voltage and current is read-only, but for APDO PPS these are
> > writable as well to allow for control.
> >
> > It should be noted that the keepalive for PPS is not handled within TCPM. The
> > expectation is that the external user will be required to ensure re-requests
> > occur regularly to ensure PPS remains and the source does not hard reset.
> 
> Sorry for the late reply. I don't have any major problems with these
> other than with 6/7. The documentation should be for the psy class,
> not tcpm. I'm also not comfortable with the "select POWER_SUPPLY", but
> if Guenter does not think it's a problem, I'm fine with it. I guess we
> can always, for example, introduce stubs for the power_supply*
> functions, and drop the dependency later.
> 
> But as usual with tcpm.c, Guenter needs to give his ACK.
> 
> Oh yes, and Sebastian needs to ACK the power_supply changes or course.

No problem. Thanks for your time reviewing this. Not the smallest patch set so
appreciate the effort spent. Was travelling last week, but should now have a bit
of free time to take a proper look at your comments and get back to you with
some meaningful responses.
