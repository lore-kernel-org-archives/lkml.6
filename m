Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EB9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BAAC205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BAAC205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732067AbeGTPFJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:05:09 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.1]:49991 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731851AbeGTPFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:05:09 -0400
Received: from [85.158.142.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-central-1.aws.symcld.net id 2A/C0-06382-3CEE15B5; Fri, 20 Jul 2018 14:16:35 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRWlGSWpSXmKPExsUSt3Opse7hd4H
  RBvc28lg0L17PZtG1eieLxeVdc9gsFi1rZbZ4svAMkwOrx7yTgR77565h99j5vYHd4/MmuQCW
  KNbMvKT8igTWjI7NS9kKJvNXTJt1ha2BsZ+ni5GLQ0hgKaPE2zu7mbsYOTnYBCwkJp94wNbFy
  MEhIpAhsfWQBUgNs0AXk8T6K93sIDXCAlESs373s4HYIgLREvcezGaFsK0ktn2fDGazCKhKLF
  t6mAXE5hUIkGi/OZ8RxBYSSJLomL0QLM4poCtxfvE0sDijgKzEl8bVYDcwC4hL3HoynwnElhA
  QkFiy5zwzhC0q8fLxP1YIW15i+7ff7BC2vcTre+9YQG6WENCX6GsshggbSqyadgAqbC6xd7cq
  xHQdiQW7P7FB2NoSyxa+Zoa4UlDi5MwnLBMYxWchOWIWkpZZSFpmIWlZwMiyitEiqSgzPaMkN
  zEzR9fQwEDX0NBY10DX2EAvsUo3US+1VDc5Na+kKBEoqZdYXqxXXJmbnJOil5dasokRGL0MQL
  CDcfavlEOMkhxMSqK8ly4GRAvxJeWnVGYkFmfEF5XmpBYfYpTh4FCS4H3wNjBaSLAoNT21Ii0
  zB5hGYNISHDxKIrxrQdK8xQWJucWZ6RCpU4yWHKeaeyYxcyy4NwVI/nk/dRKzEEtefl6qlDjv
  IZAGAZCGjNI8uHGwVHeJUVZKmJcR6EAhnoLUotzMElT5V4ziHIxKwrxvQabwZOaVwG19BXQQE
  9BBPQVgB5UkIqSkGhi12Z7wCP1v9RKfa5zIEa9n9M2q/3n8fVupTL7rbyK2p7RaXSrecujek/
  nz5ztu9Usy3vJEjf9Y1D2FpGlaKkf0pwcaNk02u/jMcL/pzjiFGZynWnqS7gsyR+7+mxcm3rS
  7YaNMb/P1Yid/Tc7bXyPmVEyXz41d2e/CzVbz5q5/sPGOd3ZrkpRYijMSDbWYi4oTAYZ+rAVw
  AwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-18.tower-229.messagelabs.com!1532096194!1988506!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17195 invoked from network); 20 Jul 2018 14:16:35 -0000
Received: from mailrelay2.diasemi.com (HELO sw-ex-cashub01.diasemi.com) (94.185.165.51)
  by server-18.tower-229.messagelabs.com with AES128-SHA encrypted SMTP; 20 Jul 2018 14:16:35 -0000
Received: from SW-EX-MBX01.diasemi.com ([169.254.3.46]) by
 sw-ex-cashub01.diasemi.com ([10.20.16.141]) with mapi id 14.03.0382.000; Fri,
 20 Jul 2018 15:16:34 +0100
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH] usb: typec: tcpm: Fix sink PDO starting index for PPS
 APDO selection
Thread-Topic: [PATCH] usb: typec: tcpm: Fix sink PDO starting index for PPS
 APDO selection
Thread-Index: AQHUHduHqMOlQ8gPmkGKByqhaIJrhqSYFyeAgAAVhjA=
Date:   Fri, 20 Jul 2018 14:16:33 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337019830B6AA@SW-EX-MBX01.diasemi.com>
References: <20180717143619.80EEB3FBB7@swsrvapps-01.diasemi.com>
 <20180720135903.GB460@kroah.com>
In-Reply-To: <20180720135903.GB460@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.43]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 20/07/2018 12:55:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 July 2018 14:59, Greg Kroah-Hartman wrote:

> On Tue, Jul 17, 2018 at 03:36:19PM +0100, Adam Thomson wrote:
> > There is a bug in the sink PDO search code when trying to select
> > a PPS APDO. The current code actually sets the starting index for
> > searching to whatever value 'i' is, rather than choosing index 1
> > to avoid the first PDO (always 5V fixed). As a result, for sources
> > which support PPS but whose PPS APDO index does not match with the
> > supporting sink PPS APDO index for the platform, no valid PPS APDO
> > will be found so this feature will not be permitted.
> >
> > Sadly in testing, both Source and Sink capabilities matched up and
> > this was missed. Code is now updated to correctly set the start
> > index to 1, and testing with additional PPS capable sources show
> > this to work as expected.
> >
> > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > ---
> >  drivers/usb/typec/tcpm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> > index 74e0cda..4f1f421 100644
> > --- a/drivers/usb/typec/tcpm.c
> > +++ b/drivers/usb/typec/tcpm.c
> > @@ -2238,7 +2238,7 @@ static unsigned int tcpm_pd_select_pps_apdo(struct
> tcpm_port *port)
> >  			 * PPS APDO. Again skip the first sink PDO as this will
> >  			 * always be 5V 3A.
> >  			 */
> > -			for (j = i; j < port->nr_snk_pdo; j++) {
> > +			for (j = 1; j < port->nr_snk_pdo; j++) {
> >  				pdo = port->snk_pdo[j];
> >
> >  				switch (pdo_type(pdo)) {
> 
> What commit id does this "fix"?
> 
> Does it need to go into 4.18-final?  To the stable kernels?

Sorry, missed that info. This fixes commit:

2eadc33f40d4c59dd0649f8b6958872d85ad05d7
'typec: tcpm: Add core support for sink side PPS'

This patch only went into v4.18-rc1 so should only be targeted for v4.18-final.

Do you want me to resend with this information added?
