Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965992AbeEIXTm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 19:19:42 -0400
Received: from mail-ve1eur01on0086.outbound.protection.outlook.com ([104.47.1.86]:58341
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965902AbeEIXTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 19:19:40 -0400
From: Saeed Mahameed <saeedm@mellanox.com>
To: "linux@roeck-us.net" <linux@roeck-us.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Israel Rukshin <israelr@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Matan Barak <matanb@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net/mlx5: Fix mlx5_get_vector_affinity function
Thread-Topic: [PATCH] net/mlx5: Fix mlx5_get_vector_affinity function
Thread-Index: AQHT5H7Lky6HIhVp9kiUqFhSa8f8sqQiUAwAgAWucgCAABDkgA==
Date: Wed, 9 May 2018 23:19:36 +0000
Message-ID: <1525907973.19800.1.camel@mellanox.com>
References: <20180505143838.GA12621@roeck-us.net>
         <alpine.DEB.2.21.1805060929540.1685@nanos.tec.linutronix.de>
         <20180509221906.GA7548@roeck-us.net>
In-Reply-To: <20180509221906.GA7548@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com;
x-originating-ip: [2601:647:4000:4586::50a1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0502MB2903;7:uUA8vPi6LKGMnXl496rimFTthIAErObguFuZ55TnKr6TsT1QP11cF0Q84xCS2SO2u/U/UVjGxLUdtGtEbHc9oT43tTjF//ExUDLWOX1LlUEzjcRFrMVUaKDafumSluQlUBWENCiKo53J2T9b3BvNUDLBu4tNfNXUJvRJwf+rpzaIS+jxEBy3pjzMndam0Lfrz0Blzo9w8qvUazZh0PmVwlO6YSjQYA0H9H0VWHztoA0wj8G+FZAGirblq84y3Nom
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0502MB2903;
x-ms-traffictypediagnostic: DB6PR0502MB2903:
x-microsoft-antispam-prvs: <DB6PR0502MB2903A79C1FFDE960098F408FBE990@DB6PR0502MB2903.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DB6PR0502MB2903;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0502MB2903;
x-forefront-prvs: 0667289FF8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(39380400002)(346002)(396003)(366004)(199004)(189003)(377424004)(102836004)(2900100001)(106356001)(11346002)(2501003)(446003)(476003)(53936002)(54906003)(97736004)(316002)(110136005)(5660300001)(6506007)(186003)(46003)(76176011)(99286004)(86362001)(25786009)(5250100002)(15760500003)(486006)(2616005)(3280700002)(81166006)(68736007)(3660700001)(6116002)(2906002)(81156014)(36756003)(6436002)(7736002)(8676002)(478600001)(50226002)(6512007)(6246003)(4326008)(305945005)(105586002)(229853002)(103116003)(6486002)(8936002)(14454004)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0502MB2903;H:DB6PR0502MB2901.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: xGVNdgRTjutVpKrn6ogjHzeUfDhofTCkOMB+Y5ptur4T5XDCDKIyOtVKiRRgZE0XYJIckGdf4cyUSQz+7KLjSB68pAv0jzy7dyMzmWLYiyjdoXxsJBTVfy0B62NUidOWCTutt9p483Oh3C7hCyJfTUzm0zE0NPdMvKEA+ZR9+90IqVuf0XZt82zlOzpkpMrm
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <49144164A709E24DBB0AFE285EBE216D@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 3641e208-dbe5-43f2-7a1a-08d5b60354ad
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3641e208-dbe5-43f2-7a1a-08d5b60354ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2018 23:19:36.2886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0502MB2903
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w49NJnef013687

On Wed, 2018-05-09 at 15:19 -0700, Guenter Roeck wrote:
> On Sun, May 06, 2018 at 09:33:26AM +0200, Thomas Gleixner wrote:
> > On Sat, 5 May 2018, Guenter Roeck wrote:
> > 
> > > On Thu, Apr 12, 2018 at 09:49:11AM +0000, Israel Rukshin wrote:
> > > > Adding the vector offset when calling to mlx5_vector2eqn() is
> > > > wrong.
> > > > This is because mlx5_vector2eqn() checks if EQ index is equal
> > > > to vector number
> > > > and the fact that the internal completion vectors that mlx5
> > > > allocates
> > > > don't get an EQ index.
> > > > 
> > > > The second problem here is that using effective_affinity_mask
> > > > gives the same
> > > > CPU for different vectors.
> > > > This leads to unmapped queues when calling it from
> > > > blk_mq_rdma_map_queues().
> > > > This doesn't happen when using affinity_hint mask.
> > > > 
> > > 
> > > Except that affinity_hint is only defined if SMP is enabled.
> > > Without:
> > > 
> > > include/linux/mlx5/driver.h: In function
> > > ‘mlx5_get_vector_affinity_hint’:
> > > include/linux/mlx5/driver.h:1299:13: error:
> > >         ‘struct irq_desc’ has no member named ‘affinity_hint’
> > > 
> > > Note that this is the only use of affinity_hint outside
> > > kernel/irq.
> > > Don't other drivers have similar problems ?
> > 
> > Aside of that.
> > 
> > > >  static inline const struct cpumask *
> > > > -mlx5_get_vector_affinity(struct mlx5_core_dev *dev, int
> > > > vector)
> > > > +mlx5_get_vector_affinity_hint(struct mlx5_core_dev *dev, int
> > > > vector)
> > > >  {
> > > > -	const struct cpumask *mask;
> > > >  	struct irq_desc *desc;
> > > >  	unsigned int irq;
> > > >  	int eqn;
> > > >  	int err;
> > > >  
> > > > -	err = mlx5_vector2eqn(dev, MLX5_EQ_VEC_COMP_BASE +
> > > > vector, &eqn, &irq);
> > > > +	err = mlx5_vector2eqn(dev, vector, &eqn, &irq);
> > > >  	if (err)
> > > >  		return NULL;
> > > >  
> > > >  	desc = irq_to_desc(irq);
> > > > -#ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
> > > > -	mask = irq_data_get_effective_affinity_mask(&desc-
> > > > >irq_data);
> > > > -#else
> > > > -	mask = desc->irq_common_data.affinity;
> > > > -#endif
> > > > -	return mask;
> > > > +	return desc->affinity_hint;
> > 
> > NAK.
> > 
> 
> The offending patch is upstream, breaking non-SMP test builds, and I
> have
> not seen any feedback from the submitter. Any suggestion how to
> proceed ?
> 
> Guenter
> 
> > 
> 

Hi Guenter and Thomas,

Max and Israel are handling this internally to find a solution that
provides the needed functionality for rdma and addresses your comments.

Thanks,
Saeed.
