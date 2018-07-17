Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB8AECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F67820877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Kn6uhTEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F67820877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbeGQEee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:34:34 -0400
Received: from mail-eopbgr70081.outbound.protection.outlook.com ([40.107.7.81]:22937
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726298AbeGQEee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MX+RMqgez5W5eYxMkyiU1X6+CryiwXHov0QOhjmLbas=;
 b=Kn6uhTExz2DpvrAKFZ5Bg9HxtlNMQsXpRhzXf667rxbOFeFFOYOFd4RQ0V2RRScj0ohyAE15+ZuMq+S5gpAF5n2Z7NShsLwGDJlX+1V4wtLUxAAUmcm+AWau1wYHe7huqxte9/yCkGJlQ46eGe1H25X7rHeTeJ/6ghr4hmaauqg=
Received: from localhost (213.57.183.250) by
 AM4PR0501MB2692.eurprd05.prod.outlook.com (2603:10a6:200:5a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.16; Tue, 17 Jul
 2018 04:03:52 +0000
Date:   Tue, 17 Jul 2018 07:03:47 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Felix Kuehling <felix.kuehling@amd.com>, kvm@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] mm, oom: distinguish blockable mode for mmu notifiers
Message-ID: <20180717040347.GT3152@mtr-leonro.mtl.com>
References: <20180716115058.5559-1-mhocko@kernel.org>
 <20180716161249.c76240cd487c070fb271d529@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cW+P/jduATWpL925"
Content-Disposition: inline
In-Reply-To: <20180716161249.c76240cd487c070fb271d529@linux-foundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Originating-IP: [213.57.183.250]
X-ClientProxiedBy: AM4PR07CA0020.eurprd07.prod.outlook.com
 (2603:10a6:205:1::33) To AM4PR0501MB2692.eurprd05.prod.outlook.com
 (2603:10a6:200:5a::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c31472cc-56b5-4382-13eb-08d5eb9a4f34
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM4PR0501MB2692;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0501MB2692;3:VBOvCEf/428Z0mmNdvfWTgWe+hhg0vWxA5qVPzgOgMyvJ1ImYuI39b8A6BKnCsVDEF+7TnOQj7efPlw3x1b5Xur80RF1qdegk2u3AEQvHB4inojv41zqp+td/+E21zWs7lmBvkllgzDzQ2UOc+zuMaeWQHuccXr/O+PsyPEWrWvjj/qE8TP0mmiuS8eow//jDrUAH7FerDhYXxdirrUXkoyw4KgmbVxuWTJR5fqyXMNq8cMVspZrGhqZKwnPWJfW;25:f8kl2wbMWGwjbmeD7PB4g29Pbo10QF0XDlV6mxiVzSYsI8f0h5a383sqkkkF50OcryD6ouDd73aejNQD5ESgAuKoFXIio+WgegRe9BLfE4i6PFmDa88rvw1jTCP1p4p5bTCoDZz2vU4oESvAsG20eWfw0UJIn3FrKzyeUGbERov49x98bi4F+GSQmRTlNvh4wW0b9+hbDCwTZiek3gh+qXKVXpeJ2gDbGZ9hgzLlGprA/PYwW5+GxOF+u2GJxe/u8uYUiYSOwyO0mhnVZdDXesAGybp0FqK7x6BJfC5L6F3UMQOFjTx2q7DRkaME/5SWxHRpFXW4/C7OhbpviuT+dw==;31:npsNBv5jK6qamEXwWOYLGk7fo+5gbTpgIDf6t7eUSIh8xPF3A0xLRGTbZMH3U75KEztS3lW2aorPWYumBGCM53P9K2VUi6+Ll+xPqHB4XUDHFdfHM4RkoEbGsoN2pZOWM3d7VXNxSrm91u+N91QXnQqlF0kxS3TfFphcaFQXYQsoGMqKN2TPNc06SvanpA5BYYVHcW7YOygG/z3Xfo47gG15NRvtcWuNevUEMTGTufE=
X-MS-TrafficTypeDiagnostic: AM4PR0501MB2692:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0501MB2692;20:ARjUGYfyqw182x9XfxPdxrHiWalflsRh9OnQ1a88lx51SY8rxu4zbbXWZ1UuyzmA0oA6IIDxArvylOOORw3Ubsz1HZIQmxAdUyvdnlj4MQARq0jFB01KkrAaBbJzyc7Pg6EisklQCzs/0AjvcdEfUOK9Ab1rk080T0tnjLoPUUR85/6wmBrPPD7FQRTAcw6cJaQks7Vnzfg3zCY7MZqOvkocR0Wq/w+WNY9zTLP8xHZeSEjEZc6hn81RuoKgTTZCHPqi8qb4auZA1KDzzKgtvigFzME1T5sAnrECLPrKcwKGVRklJAQI9o/mRojPjEONBe9nM8g5Wky7c3M9hJib4sycWecRZQ4t4Q+LLiJ9MGNHcmUUQgBOclr3S4PU7PSi5HMOD77zxOqxtCUPvFMVD2WBhosJiJX7n7qXxWAJ+IGru8qdJcYvJ4QZSFu3c6Eqb+KSuQJwz9wo15pbvJv/fb9GRjHyxEf6GkfQhimH8ovaeij1qQcv7KryVYrvJDu5;4:MQlsIsyPAWtRzgFs6K2rYxKkNpft37a6AxXR7XP1wp0cy9eiNXTVaJyTI8i8QI2+JRXhF5brBqN33mj/z8JPiuQI8MeevZ+PTkNd2nvgjzPk+6FO4yn7iuJ3WUsXhoFzMCAkV8qVGTL11IFpX+CGg4fuTAJERR+XIbJHX1voDMN92HVLBj0AIl9dSvQLY8OepWc/qYIazEU1M1lTTR5BX10Y3X1N0Crmu/cZEsUoYswtNaC2yUJr7uyzvBDicxtyXPDwzXMWuK+JEmnTAIZJJw==
X-Microsoft-Antispam-PRVS: <AM4PR0501MB2692FB4507F6D0D0288B32D0B05C0@AM4PR0501MB2692.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM4PR0501MB2692;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0501MB2692;
X-Forefront-PRVS: 073631BD3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(366004)(136003)(346002)(396003)(39860400002)(189003)(199004)(25786009)(105586002)(1076002)(3846002)(6116002)(106356001)(8936002)(486006)(53936002)(11346002)(16586007)(316002)(6246003)(97736004)(76506005)(33656002)(476003)(54906003)(4326008)(956004)(84326002)(58126008)(6916009)(81156014)(81166006)(33896004)(386003)(8676002)(66066001)(186003)(21480400003)(16526019)(68736007)(26005)(86362001)(63394003)(5660300001)(6486002)(2906002)(6666003)(7416002)(229853002)(7406005)(9686003)(76176011)(44144004)(52116002)(446003)(6496006)(7736002)(305945005)(478600001)(14444005)(18370500001)(2700100001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0501MB2692;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0501MB2692;23:qV1Heo7nCJ5OvTBsVyE9EYhYX0s6GfcTQC/V2Ee?=
 =?us-ascii?Q?5lth1p3H7uJm1iptT0XBF8ZmeFMu2KjEU7uN7wQKjVWWOF8qGH8OG21aq1e9?=
 =?us-ascii?Q?3P2mQuwulKgdURKn91XVWVgHjgwiHy1F/bGweu6k0alzMrlXG1l1LfPX0woK?=
 =?us-ascii?Q?iKMZIgkSewKLWOXkLJT9NrdTV1tdvWBiz3X3TkWOeedsn02TMvPIB0SW3PjH?=
 =?us-ascii?Q?UPYUsPiBLWQLzm5SGcIRwIK991aprciNJyjyXn6sqmQmuJpx+QFDfp3q57hU?=
 =?us-ascii?Q?qeqBfIRbYtMWfYsn8nh49/8ba6YWGJepfpUZ29HXMd6cB+ijskqo4f+1bF1t?=
 =?us-ascii?Q?OddNfF5Mlwm9cLuJ62nvm90wXXqbolaBKl/3Zub/s1h0dqsW0OeGam2tbBBh?=
 =?us-ascii?Q?bxR0cQQxjc53IwJX+3rWZ9kbvq9nX5hY14Mjdhr+5Z6xRvIEADmBENbQoAMJ?=
 =?us-ascii?Q?9wFB3WGDh8V9ZvFWEy4i9HaqtA93bLueeOLyp7N0a6Fey33WpJHoSVvC7IZn?=
 =?us-ascii?Q?zDCO+sk7F43gF2oox2BPVH8UjkHGv7R80lRWGR4Pid7Hd4WLYpxe8wTanPEp?=
 =?us-ascii?Q?wd3CYvztIKew0bKRj4ECvL7XtuTA7uLyNm+2GBYDAEU2FsOVqWNbiO7BLjaj?=
 =?us-ascii?Q?MdGyi+4y6qbJS2mElQdtDv4lLSwSOO8oonKWG7nXPRyvAQ1nkBgR9rm8H7L9?=
 =?us-ascii?Q?DSLEXDeQxN9RqkUUZSHMS2cE+NbOzWw/+NSVPsm+MHC/vjWQ1wk+/Nzbz1fj?=
 =?us-ascii?Q?bbvUSy6ZEi/l2xIKtr0wbJQIneq2Oki78aH1//EHWryesjazUL/O5WaOjjuF?=
 =?us-ascii?Q?d5aC74kFDH838gWPxpGytC9mKh6IPkugpMFi5jT28u0ZJQYpoXfcZaRnVx+H?=
 =?us-ascii?Q?GCMyVFBD8TDB+iv5lwTADYN6oF9PbFZVtaICKLuIsnZYnZpDHAfMFSaAzjr0?=
 =?us-ascii?Q?SzA8Sklx+RGswbm3sJVooP9fi8VcdgbIFuRBZCw2zinxlp7ImzKBBpniycW1?=
 =?us-ascii?Q?7uN/cUdV1QJWae+MQsVYHyXBwPcJ7fzcM1eIP0SqJuYAb92J7gto2AR3Rfap?=
 =?us-ascii?Q?Lz9rbvwfkBZXqvgX+nMaDx0JhbwsiqIkYxuedHhIKx43KWLJr086w0jkFhdA?=
 =?us-ascii?Q?eZ9iHfOgND18DpXjQ9ppKi4I3++vhYEX28+pynCKLSRw6K+TyNjqWshrnet0?=
 =?us-ascii?Q?c/6Ts1QlU3P3WSllhwz1DLHWcXnZrWn63mfQrVy3Ra1nTg0G4mnap09i5YFV?=
 =?us-ascii?Q?CSCvXGGk/yB1H17Stjgod4P3mK3vAsizXxve13oWo8GYy7ziJsIzlLeXMZQm?=
 =?us-ascii?Q?seHSnG4RE/I7dagV7nOnRYhYbQ+xSu62j3MM/E86lAN5hdwQcWFnek4p4I2N?=
 =?us-ascii?Q?ds9Ow4mdyqPTg/zpm54qKOrAOimIx6BIuOfpI+k+oKTRI/PZU?=
X-Microsoft-Antispam-Message-Info: CfCn5zMc/D9EJr7t3F3helmr7X6ds8LvDIVkuBYVS9rshPHoHDwuwy31ifdR7TJ/ABPSb4DHkF9IrzYBgvCnM77U4OCi39cUNjDXIgf1geSxNegDa1G650UEqLJ2E6WwAdORUDKxLnvnvEohnGKgWKXIoaKE7wg+MvMboQ1APxHDuJ6qBaZEw3bc6oNOG/0Mg2CKPi+8cDiQov4V939yJ93b18Ak2lbN375PHGMMQHbbTmmfHXC9PHJwzyZyo2YAT1RFZn6zJH1DnalYgomMYbCKLhFBEmL0AzalHPwsBtCiNxA7D/sGv8XhLYC9ZCW5bRsqNcilchU+yfJHxRWXJM4SKcrcj1sZ2lDXOHV7ClM=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0501MB2692;6:cs0k5KOiEFlR+YZVtTlJ9FfJz1BA8FsE/q/tWbfT1EZ5hyuRXmThmxypvFZoMvll6NHDX0fz8HUTrkwlFNLjC6agk3mYOCIk0SbR8S8PbhzNTIjwpGJyPHGFWbWYF11QwvDWqSMf0hy9YLRi1i2J2uRNL7I7NFHNezvswwkfgNxTUo4mFrdHNUsmGuCDtQyK5K5AZPQLoIPJ5f0rV6Y288W3ecr2N2LCgjr21GfQ/ABbJs7DjON5ssqgwpVXfaOFnyZHAXfrXPAqXeu9RR994qRg7hrPrWFc5j7hoyrIwQh6efu+N8QnFHHx5u/7/YBcVWBc1PS/vcvy5fIH0ni8g+0lr+dI+YGF6eOVFCR8dT1JaL+ya64/MIKJtercyVcqqzxz2FTjjdvQFuHc1q+6mkTqNQkfSnbJKOVajYapzQjDdtp9iePX6CifdGfeWjtzbMompjyOac1uxJ/Tk+E9Sw==;5:h67kjGWV9+OpSSVv6bmqxLs/uEDY9B3ZYh86SC3SU4ggM/x5e5cduSv9M1I2dJ0K/BB82zBDfqFGwU55KfGH5PTMwhuL6kkPb+uClwVd3Gqcps+a8IqSZc/i0MSuvmVRc9mWsDFLtsTLdnY8rGw3PymB7nISipx4tSWyWWn7le4=;7:mhqLllQfx6McOF5SBwU9NADUk74GInTwlSIp0stdxRr8QrXBkkIwVs9jXr5xjZTXvNWn+pzSIi/uoOoCcaMtglJGZpgW5fmUiAesU9sAeXdFEzF5nb1hHJmHTexbyVaf+bRxpqjKhZI/zWjwdzivLAxYRqzVBLM5XJCl7IlbgeHZ9q6DOg6Zl4MVKSzj1VJ/+EQKaHWtMPo2CK6xT/rxi9q3/WulS/OgMw4eFkkfcWvLCWhey3QyND/8+xnKLPij
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 04:03:52.5190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c31472cc-56b5-4382-13eb-08d5eb9a4f34
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0501MB2692
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cW+P/jduATWpL925
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 16, 2018 at 04:12:49PM -0700, Andrew Morton wrote:
> On Mon, 16 Jul 2018 13:50:58 +0200 Michal Hocko <mhocko@kernel.org> wrote:
>
> > From: Michal Hocko <mhocko@suse.com>
> >
> > There are several blockable mmu notifiers which might sleep in
> > mmu_notifier_invalidate_range_start and that is a problem for the
> > oom_reaper because it needs to guarantee a forward progress so it cannot
> > depend on any sleepable locks.
> >
> > Currently we simply back off and mark an oom victim with blockable mmu
> > notifiers as done after a short sleep. That can result in selecting a
> > new oom victim prematurely because the previous one still hasn't torn
> > its memory down yet.
> >
> > We can do much better though. Even if mmu notifiers use sleepable locks
> > there is no reason to automatically assume those locks are held.
> > Moreover majority of notifiers only care about a portion of the address
> > space and there is absolutely zero reason to fail when we are unmapping an
> > unrelated range. Many notifiers do really block and wait for HW which is
> > harder to handle and we have to bail out though.
> >
> > This patch handles the low hanging fruid. __mmu_notifier_invalidate_range_start
> > gets a blockable flag and callbacks are not allowed to sleep if the
> > flag is set to false. This is achieved by using trylock instead of the
> > sleepable lock for most callbacks and continue as long as we do not
> > block down the call chain.
>
> I assume device driver developers are wondering "what does this mean
> for me".  As I understand it, the only time they will see
> blockable==false is when their driver is being called in response to an
> out-of-memory condition, yes?  So it is a very rare thing.

I can't say for everyone, but at least for me (mlx5), it is not rare event.
I'm seeing OOM very often while I'm running my tests in low memory VMs.

Thanks

>
> Any suggestions regarding how the driver developers can test this code
> path?  I don't think we presently have a way to fake an oom-killing
> event?  Perhaps we should add such a thing, given the problems we're
> having with that feature.

--cW+P/jduATWpL925
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbTWqjAAoJEORje4g2clinGqAP+gKzC/GfmPDn9AVen4vgye2r
8ZHefQ6uHWv4nJE61TvooYoxviDwWVXtXhUT+MnvEvQ43UMMtfUc4ZyBaHovPPmr
a6eXZGQP9+08P4l3nl3dPg1H9D1ynkxSqKLJykEM+xSzWy16+F3JYQXUnTcujqrn
m/eiJ9hHXL2sS2w7Xwj1BLmCmeMJ/e7v6Og0eUkXeCIYHrtBfUziO+XhMwU6BEKE
uNsyROY/ua4XvzuHWwGmUbM0pT1Pk/qvkHGK8RP1jkBbzS0nlYZoKKtlgH0E3Cot
ifa7ZfLQT4kG1KttzXX7ZVuwxK+wyKHhykJxlJIRl/uDSbmdEjRcNPFwAwzAsQLG
ZMjnx2wo9tqlBMSdwlwtZBc8H8MPagM5pLypQTIFdMmvD/lGVGXk2/rwP2dixw/W
V/j9V5eWAkjkp2hg5KxZLSW0nK7e1bEreZesEejfWb/tZGpEWjOtDfv+F9drZZ8O
iqvT56/bALDpLSvSDaCTxbfVpZf6wm+eKE4DkwIBzl8cTyRp7136JKnDJ0FVse/Z
OGqa7WWV1LTVMAHzRsHpX9HrTPpRKxFuZYYB8Z5NTeHa0TVqjsuOYo5uf5SfVsS5
3BeOAh2ncekLrn5WyVnY78PaXLzJ1vUCtvQGOYMX6fwI15+63z3+BH8t46ulmJed
MuCRD555f27+kAwtDYmE
=gzyd
-----END PGP SIGNATURE-----

--cW+P/jduATWpL925--
