Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965621AbeE2R6I (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 13:58:08 -0400
Received: from mail-cys01nam02on0051.outbound.protection.outlook.com ([104.47.37.51]:8216
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965391AbeE2R6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 13:58:05 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: "Konopko, Igor J" <igor.j.konopko@intel.com>
CC: =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Dziegielewski, Marcin" <marcin.dziegielewski@intel.com>
Subject: Re: [GIT PULL 20/20] lightnvm: pblk: sync RB and RL states during GC
Thread-Topic: [GIT PULL 20/20] lightnvm: pblk: sync RB and RL states during GC
Thread-Index: AQHT9nHUs6xdt5lKsUCPVeEXWKblWKRGrv6AgABRRoA=
Date: Tue, 29 May 2018 17:58:01 +0000
Message-ID: <C700A382-1588-41B2-A1DE-7F6C1C5E1F29@cnexlabs.com>
References: <20180528085841.26684-1-mb@lightnvm.io>
 <20180528085841.26684-21-mb@lightnvm.io>
 <23C83C0A-B4FC-4472-B88B-4C7725F793FD@cnexlabs.com>
 <76C92B909A93A84C99173B331AB578DAC7AB520A@irsmsx111.ger.corp.intel.com>
In-Reply-To: <76C92B909A93A84C99173B331AB578DAC7AB520A@irsmsx111.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB588;7:u0F82GPqx7vi9K4r7BUTehXKomrHiVistA4b8sOGszPtGljZIeY+JKH+3adVdwLFIDd6KIJNMWo9VAoQsExwptKkMftRIqT6pvdx7c4GxcEDD2botbOhy1K4k0P42OIWZJpY8xHzXd/HbqwOUflixNVMwpOoMb6P9/RQObmQnlOBGCpBJ+m/YoyvJckReHKzqZMVaZ1/4kR+MbtMMm2nt69zvxYRd59lzAkeo6HxTvnAMCmGWgI/OkFZiri1zH25
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB588;
x-ms-traffictypediagnostic: CO2PR06MB588:
x-microsoft-antispam-prvs: <CO2PR06MB588D46B38055F03C046D0C3BA6D0@CO2PR06MB588.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(131327999870524)(228905959029699)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CO2PR06MB588;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB588;
x-forefront-prvs: 0687389FB0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(346002)(366004)(376002)(39380400002)(396003)(39830400003)(51444003)(189003)(199004)(5250100002)(2900100001)(53936002)(5660300001)(68736007)(99936001)(6246003)(6916009)(25786009)(6512007)(76176011)(33656002)(446003)(11346002)(2616005)(4326008)(476003)(106356001)(486006)(105586002)(3280700002)(54906003)(102836004)(66066001)(3660700001)(14454004)(83716003)(8936002)(36756003)(81166006)(81156014)(8676002)(99286004)(478600001)(82746002)(26005)(186003)(93886005)(7736002)(2906002)(6486002)(59450400001)(6506007)(6436002)(86362001)(305945005)(316002)(6116002)(3846002)(97736004)(229853002)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB588;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: jUXdfLYVP5x1ustTDJ4fU5X2fCJk0rSomOyhCxhasJqYu3xvNA5NJYQ9ZGJAftF0HyHteglgkFMJWaqmskTOyqP/Ilp8B85iG4FcH7z/2F0l73vJHmXoVzRJQwYjoRXjuBASG+JiF/BFCSdWGMuYemYOrQJ6yulNs3mKkecOYj7xBa+fxwB4/H3Q0PVg9aBo
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_C0CE675C-FC26-43CA-8AFB-4BF7FB8DA228";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e1dae6b6-cc93-419e-5887-08d5c58db893
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1dae6b6-cc93-419e-5887-08d5c58db893
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2018 17:58:01.9424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB588
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_C0CE675C-FC26-43CA-8AFB-4BF7FB8DA228
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


> On 29 May 2018, at 15.07, Konopko, Igor J <igor.j.konopko@intel.com> wrote:
> 
>> From: Javier Gonzalez [mailto:javier@cnexlabs.com]
>> Do you mean random writes? On fully sequential, a line will either be
>> fully written, fully invalidated or on its way to be written. When
>> invalidating the line, then the whole line will be invalidated and GC
>> will free it without having to move valid data.
> 
> I meant sequential writes, since this is the easiest way to reach
> rl->rb_state = PBLK_RL_LOW. When we updating this values inside
> __pblk_rl_update_rates(), most of the times rl->rb_user_cnt will
> became equal to rl->rb_user_max - which means that we cannot handle
> any more user IOs. In that case pblk_rl_user_may_insert() will return
> false, no one will call pblk_rb_update_l2p(), rl->rb_user_cnt will not
> be decreased, so user IOs will stuck for forever.
> 

What OP are you using? Even with a 5%, full lines should start being
freed as they are completely invalid. But fair enough, if you decide to
optimize for a guaranteed sequential workload where the OP is only to
support grown bad blocks, you will run into this issue.

>> I can see why you might have problems with very low OP due to the rate
>> limiter, but unfortunately this is not a good way of solving the
>> problem. When you do this, you basically make the L2P to point to the
>> device instead of pointing to the write cache, which in essence bypasses
>> mw_cuints. As a result, if a read comes in to one of the synced entries,
>> it will violate the device-host contract and most probably fail (for
>> sure fail on > SLC).
> 
> What about using on that path some modified version of
> pblk_rb_sync_l2p() which will synchronize all the RB entries except
> last mw_cunits number of elements?
> 

Typically, the size of the buffer is the closest upper power of two to
nr_luns * mw_cuints. So in essence, we only update the L2P as we wrap
up. You could go down to match nr_luns * mw_cuints exactly, which
depending on the media geometry can gain you some extra user entries.

> Also you wrote about mw_cuints definitely makes sense, but even
> without my changes I believe that we can lead into such a situation -
> especially for pblk with small number of LUNs assigned under write IOs
> with high sector count. Pblk_rb_update_l2p() does not explicitly takes
> mw_cunints this value into consideration right now.
> 

As mentioned, the size of the buffer is always over nr_luns * mw_cuints
and we only update when we wrap up - this is, when the mem pointer
(which writes new data to the write buffer), wraps and starts writing
new data. So this case is guaranteed not to happen. In fact, this
particular case is what inspired the design of the write buffer and the
current 5 pointers to extend the typical head and tail.

>> I think that the right way of solving this problem is separating the
>> write and GC buffers and then assigning tokens to them. The write thread
>> will then consume both buffers based on these tokens. In this case, user
>> I/O will have a buffer for itself, which will be guaranteed to advance
>> at the rate the rate-limiter is allowing it to. Note that the 2 buffers
>> can be a single buffer with a new set of pointers so that the lookup can
>> be done with a single bit.
>> 
>> I have been looking for time to implement this for a while. If you want
>> to give it a go, we can talk and I can give you some pointers on
>> potential issues I have thought about.
> 
> I believe this is interesting option - we can discuss this for one of
> next releases.

Sure. Ping me if you want to discuss in more detail.

Javier

--Apple-Mail=_C0CE675C-FC26-43CA-8AFB-4BF7FB8DA228
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlsNlKcACgkQIX4xUKFR
nnTIMw/8Dw5SZSWEWPhMqGQCRosEbHL/1UhKTSweep/rRtD5FJoy2c6jGzAh7s2E
FanY5jkoyA5xTnFDNCmMQopFupiMMaCDPzUjLF8g31Pssc/d8YVRNFlSXRRyM5dC
7TQCFQZj1E5+KcGsWo5CnQHnKN7wb1OUA8r/GIUAJ2bwiAxuWOxB7RVgCtljhKik
BEvhapSPzxUkwyg8hOHqGCrHMvg3InDdrHpXUcTZEEBqwVCZW6w8sWPSBJ1WjEEj
SBXYtu1zrXd57nlhuZKBBQf9hEJ+W84hfSGB4gr916IMeIwoR8d2OyRHvHaWixx1
R+S5o5EYhZq4c3CjbDBHBlHl3jkpK/apdy6xnl1mGEueJdfBsFKv3zRk25TOETF2
rs/ETSs7aB4ipr27Ra0IIWe3RnxnTf40ea85NhUIndNzjzhmHPAZpVdfqLo2WmT1
hG0qcfpjwkmTqnfmRlm7BhhIAoSU5lCh4DCQCw7EUiB3TqdwBCAE3KFfofHPMEab
1dpq6+VKc6KQ5rKgErU/FFP2KHcr7L3+LPvYNOarHsIvePkVVhEhgyowD9lvHEVj
Ol7vfOwJcz8jTHKGAy0LAdxj1PGLoMeAXBZEcv6GU4LGoIMO1VQvnYd8O7rt6IDl
41/3z5DCQQPSIPLcersfXr0fGbFI9dwaD5ReF/mbmoNTlER2RNM=
=PDNr
-----END PGP SIGNATURE-----

--Apple-Mail=_C0CE675C-FC26-43CA-8AFB-4BF7FB8DA228--
