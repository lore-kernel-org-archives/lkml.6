Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90B8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE15920823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbfARJ0y convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:26:54 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44995 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725856AbfARJ0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:26:53 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0I9Q2eQ030668;
        Fri, 18 Jan 2019 10:26:47 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2pyby1pput-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 18 Jan 2019 10:26:46 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2FD3A34;
        Fri, 18 Jan 2019 09:26:46 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag7node1.st.com [10.75.127.19])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0A6A4258A;
        Fri, 18 Jan 2019 09:26:46 +0000 (GMT)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG7NODE1.st.com
 (10.75.127.19) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 18 Jan
 2019 10:26:45 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Fri, 18 Jan 2019 10:26:45 +0100
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Subject: Re: [RFC 2/7] domainsctrl: Introduce domains controller framework
Thread-Topic: [RFC 2/7] domainsctrl: Introduce domains controller framework
Thread-Index: AQHUrBdmkQbOFJl8106mIDHzMYNXUKWzqwcAgAEL4oA=
Date:   Fri, 18 Jan 2019 09:26:45 +0000
Message-ID: <7a1c6906-7b16-317f-ead8-35bbcf07d95a@st.com>
References: <20190114144202.27315-1-benjamin.gaignard@st.com>
 <20190114144202.27315-3-benjamin.gaignard@st.com>
 <20190117172758.GD7003@sirena.org.uk>
In-Reply-To: <20190117172758.GD7003@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <2D8D4C63715E81438EEEFCECA4CF00B5@st.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-18_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/19 6:27 PM, Mark Brown wrote:
> On Mon, Jan 14, 2019 at 03:41:57PM +0100, Benjamin Gaignard wrote:
>
>> Configurations could be applied with functions like
>> domainsctrl_set_config_by_index() or domainsctrl_set_config_by_name().
> Do you have any clients in the works for this?  It seems fairly likely
> that everything is fine in terms of setting the mode but it'd be good to
> confirm that's the case.  The main thing I can think of that might be a
> problem here is how you'd handle a case where we were talking to another
> processor that owns the permissions, we'd probably want more ways to
> query state there but I'm thinking there'd likely be some other higher
> level way to talk to the other processor there so perhaps it's moot.

Patch 3 use those functions to apply the default configuration before probing
a driver (or after unbind it). I have in mind that drivers could ask to apply
a configuration like it is done for pinctrl in resume/suspend functions.
An example of that could be to start the hardware block on the main processor
and, when going to sleep, change the configuration to grant the access to lower
power processor.

I think that talking to a remote processor is another problem already addressed
remoteproc or secure monitor calls. Domains controllers drivers should be created
for those cases.

>
> Otherwise this all looks pretty clean and simple, there's some handling
> for probe deferral in there which is the only slightly complex thing I
> noticed.
