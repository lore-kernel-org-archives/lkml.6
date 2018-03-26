Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeCZQls (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 12:41:48 -0400
Received: from mail-db5eur01on0053.outbound.protection.outlook.com ([104.47.2.53]:3296
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751489AbeCZQlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 12:41:45 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com;
Date: Mon, 26 Mar 2018 10:41:29 -0600
From: Jason Gunthorpe <jgg@mellanox.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Logan Gunthorpe <logang@deltatee.com>,
        Sinan Kaya <okaya@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-block@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>, Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Wehage <Eric.Wehage@huawei.com>
Subject: Re: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
Message-ID: <20180326164129.GF15530@mellanox.com>
References: <20180312193525.2855-1-logang@deltatee.com>
 <20180312193525.2855-2-logang@deltatee.com>
 <59fd2f5d-177f-334a-a9c4-0f8a6ec7c303@codeaurora.org>
 <24d8e5c2-065d-8bde-3f5d-7f158be9c578@deltatee.com>
 <20180326121138.00005e30@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326121138.00005e30@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: HE1PR0202CA0023.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::33) To AM0PR05MB4450.eurprd05.prod.outlook.com
 (2603:10a6:208:5a::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 14a419a1-af21-469d-5d5f-08d59338732a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB4450;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;3:lCvYI+Rb9vagQyMf5rD/53KR2vIVtTBFTe3KWvURmX9F9F2odXSf6mPiuPOJVtddPlt95mDamYV6GR6NVClxojcbCyJPRpzZSaV0lmAs5LpQpoDzy9LgrUMtA/D/PM+J30EFS6TX2oODuYajriOhmGLsDHE2PWCfQlAUWlf6Jm/QMRsejeu23YqGKkHuaVRFzeiOMyoLvvdwLjSg7FVttJxOi0YRiSl/WUkSTP7k8Yb/eaDJC+vQWwOu80/8uNkx;25:ffl9KZhSZpf/HwRvAE1n4XGbvKNZhgUe0op+aN2kAnwIVJX01EduPvK+lkYOdFbscOPtIgqtoO9nsolFnTjOmRuTzsEL1SHx+cW3NEOQ5oNgREaVPWIZ79DrlI5OsD05HvMQ3FhIMksrW6axmcdv9ryeBCB/PeSsvU+xETJlb7Urc58hScWIkqd43sGn1WFHcazgcY4eY4o7o7yS9+0eFZmU67DVse7VG5jydL8w5lZeimnWTyLBaRnzRrRY7q8HxWrBYq6nvLypJRQ0mjOLfVoigQnS5RkykbGl8Tdm0ZbcipnOvXnOAI1dj4E6VCzb5yDVeWmnN4jX/cvcrFrU1Q==;31:c2qS9gW32AO7/STL9Udj/BG4tLf09GOvHwylZaV5nDmqBM2NUocoLsnkA13Tb2Qwc4Pqu2+alvNzP9w3ZrbIH/W0pl3LZ/Ae16iAghb0W+iy1ZYOc7mLuJFwUYf78V4PPHStsxOTNgADiwZ49h34/PU4KysGyAetb5gHpG1pH9sbKpROdg2IYBFJQBujMRJgUye9GeRu5vX3ygrz4M6YvR2845e3Obj9KLn5af9/lhw=
X-MS-TrafficTypeDiagnostic: AM0PR05MB4450:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;20:WDL2yFyWEjIYCSi8H7LnhexpBspIpD4TUTzAzvRiD0Xg4dnNCYQzkezID2djzYClOJ9qU+RTmbrxs8QVlr2ZNGSG2z8pxFcG71pPVoDJwAewV1gIetNXgeeS56d3A9+9nf5BRt5DQ+FoK0mDINgtRlpV4SAOoSvRzg1RFF52D/IIxojc0fiPWSDcTcKoR9QR8ncfKQomFLwBP+N1iEVR9a9UmvrJeZP9N2fGJ94uiEZnMDfHIUksrQY/t42MeTi3EP+IkmeVGKTLjfMzi4rJH4QJCfUUKgn2QVXQ5VPzueYywsQZoJ/dS6tF3DYC/QMKdNTSO5kurwA4JjQH0ZZyEikxcur7TAchWSdX+qAXtvp3k4egp4POhTfKFOerZjPIb8gG0nABYzpEwYiEXXMUMq0xKem9jjOIfaM9KP+opBesMhpE8KRq6yEL3v+xvC4+Lb3Rl6Y+3dR7osJzCmZopLJTyBIo21LOkoVo0MKgkiFpHG1HamivczNDOCPdggNk;4:80QLXSrj0KbtRc8EqoX0BRef/sdptUn0bDbnKAQ08LZSmJYBP7OlKX8EbWoOvgqA6F3wErnVheg+dej1TmRb8A5j3iqg8snpmtI4kD0L3dQysXJr9Vmz8I2g9LheF7VwaoaP+HNmmqjniHBcd4+PZ7xtPTFZqe9x5wrKPRuAfrdqfDD6hDKxbfVv7UqOBRyixuK3YVZv9NttzhpgTm7tJ09vIYeh0/yGZHjOhtnhO6rcQn5Ly60tfUc4bz7EpNOmpXKazNPK9IVsuHr25eWq9Q==
X-Microsoft-Antispam-PRVS: <AM0PR05MB44509D403B2BD760C7390ADBCFAD0@AM0PR05MB4450.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:AM0PR05MB4450;BCL:0;PCL:0;RULEID:;SRVR:AM0PR05MB4450;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(39860400002)(346002)(376002)(366004)(199004)(189003)(68736007)(316002)(59450400001)(69596002)(83796002)(11346002)(46656002)(66066001)(229853002)(47776003)(16586007)(86362001)(52116002)(36756003)(93886005)(486005)(486005)(53546011)(76176011)(386003)(5660300001)(33656002)(478600001)(186003)(54906003)(26005)(4326008)(2906002)(106356001)(9746002)(9786002)(446003)(3846002)(58126008)(23726003)(7416002)(122856001)(53936002)(305945005)(7736002)(6246003)(1076002)(6116002)(8936002)(2616005)(105586002)(6916009)(57986006)(81166006)(97736004)(81156014)(50466002)(8676002)(476003)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4450;H:mlx.ziepe.ca;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR05MB4450;23:3tnmtMlfr0G0nq6Jt1BCUxGgE6ITbpm1BWy9stzmD?=
 =?us-ascii?Q?3rNydrhSpDpxfXKwGnmuFavR+B1R4l/9aYcQkgJyCpPaoiYP5JljIw9Sp3yM?=
 =?us-ascii?Q?EqC/uqpHySDRC3gaYyS1DI/OzBQIbptL5oUwUc3UnVKp9E83Rk1h3Pl+bQdM?=
 =?us-ascii?Q?utKq8hYEKn+ibGcb+3UwOq5yA6tcy5LHNr66vliCEZybPJkWnOt32g4c8sZJ?=
 =?us-ascii?Q?hG/OWzJfDrpy0YNxImDaZkjaMBuwB9OgLN5jlx4yPKfiF4k67c8gmaJ1Ln/U?=
 =?us-ascii?Q?Pwsij/GQHaH6QQF6YQPFVyi3TJSfiGIc1NDLPtamOsOc3N5KBCqCmCLhc1RT?=
 =?us-ascii?Q?eDn92nbkhogQsvw/niJw9xcMbJxHMV0eczet5LJI6I88RoLdPJwSOOU9qqKM?=
 =?us-ascii?Q?VEL5ZyzWem5gzBA1r8wjlyvU8aUcPhL4y2jrCn1g2xShirhw7hoUHn2aOfcz?=
 =?us-ascii?Q?2bD5tmeSY/PoJ8wDVxSoybGSiz1mBq7aWsf+2zyVUu4bB4FNiaQj5uLHTZOz?=
 =?us-ascii?Q?FbaJ2bnesyyjf0nip3qY2oLJUiiMWVHwR7Y1QzP8DD56U4le/mP19nId6Lql?=
 =?us-ascii?Q?AtrXn4vM0eXy8XmA2YwvR1Qk+WfQRSmWEbFku32bd8uMuhqxRjbOtgMtaQIR?=
 =?us-ascii?Q?0teebGqVIuoDhInhjfKSoC1HBCsyx9btuWBEnzSu9K4eTiewhintYLWVkm+R?=
 =?us-ascii?Q?EWu7zxyYRvYM+6Bk4yHqUQ9IX5CKWI4X5BUTuUPB+ENHKVF8uBSDu4giX3lg?=
 =?us-ascii?Q?kwoBSej1DW97FWFxX7ZZoqrxKxGK5nTqJHgXO6XJB/V90JTdf0qHiFqF3ffa?=
 =?us-ascii?Q?Sc1HQey04dDyX4LDwujVaZ3T+HViNWZRaizWrleVOP9XMRmwRkg79YUUb922?=
 =?us-ascii?Q?oUTRl5wxk9kK12lxwFXBD5RAOQUA68ie5aMt5gHdimMKYQD7C52bCykRtV9z?=
 =?us-ascii?Q?WC14rgBYcBKGZNs896nB1JUJ0zhs9u5TLKuMHM4KydGLGbVncTAhS//1PDST?=
 =?us-ascii?Q?m5ILo+5wQvR0l6oIWLvirQHugLZk9pCIFYcL0pS8K4cbVqsqlPJewx99SXXn?=
 =?us-ascii?Q?2uVZxWTIsu+2znSdA12Bf/OmIr9R7SOrXuSw6etyYbD7pNA+V5tMx6xzdQXM?=
 =?us-ascii?Q?Rl6AqgNbhkFtYwNTRJTCDSGtRFLCabWr/oQSQc4kCnOfUlDba6LnEmK7rJOn?=
 =?us-ascii?Q?SVqfcc+dBJnCCME1TyyYGrQDFBXuuK9XctE5uyC9hMZEicRpS5YYxzpUM9DH?=
 =?us-ascii?Q?RWQAOt542yGks+qabm/9Qj0RTIvGhYpU3KrD/CP4zy0x7+5wVjumo6Mi7L6p?=
 =?us-ascii?Q?LtDb4gDluqGiWxn8vk1OBPAKA7Ofw7aisFPYoYh18nNMQ+lKgi1IFehHiRly?=
 =?us-ascii?Q?eviOPa4uMJfwOQLsJTq8DuFhksrP5x0ivWSfUGFTyNMZtSGYunzAeVsWrpG8?=
 =?us-ascii?Q?U/tyxOefZo0RNmDPFcK/q5B+V0hfdzqWOCtfSKTkJ/C4PilIrKC?=
X-Microsoft-Antispam-Message-Info: dI6TSA2GfLbAE5cKEJHEqkZhaxAJLa24OuXwL0o2cEPaESnvS4e3O3OUPDIYiWXFO36KdVe9TpHHsBjbnq8iA1BqHznTGzPZZ4Ja4wPoUNg4qircMamaBpKNez56rjT1qIEQZ8WuG1ALQfwHJlXTwc5OgJtFEHX2Kw06OEe/Cch+osIybSpo5bRUDNkBelfo
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;6:TVnwSm5hTNKWaSbH+vOBwvveIELjRRyji5fUIyycWrW8cgTr8NlzRkbDjrjcs1CKMzDUdvDSJhuha+f0dKhbsF+xHgq1hkCoyRFlw4xjp8iGnohZ6UHB1wnh3YIZDvvys6XajukG7bhN3Dja3oUj0bbPs9OvasAC7Dj+RottcWYHZgD7dEkR0Y6gI6EfSmO6/EJFVDDX8FroEjaZSAsHZSHyfNFnRP3ei3Ssc9CxKspeoRCzsSs4wjA0JJGG58sCsq7102dhlL5W6wmZckS1L9HgGWC1Xvl4IdQQqMu0011xp2g9DOtgRECCEuUFpR6MOCpi8gE4pq0ad7Yhne0pu7To2Xib/Stys/XBKvAc/Gfh92UD+CPv/eK7O7RC95ad6+4/UO/TJt+voNdPExYu/SpKzWXDaOujlM47aFbv/g+Rp8E6MW2h+U95wsCwhP1yWHTfjEcQu84V+FvW8ZlsWA==;5:UzXX4BI9MqqRLrWkIG8pZEi7qFCNA8x/t1a0WDbkWo62nrAWnYGokQ0HuYpc/pps2S0jG8US4m38/7ZHS1dACTlEXX6m6al8pA1MDAOS27tY5HrJ44T5asr/ecIJADVYZVlqtLqV3e8VNr/4UFQkGADl4gjfj2twnq9zuYNBmD8=;24:qIoLZ5q3O4Dc9z5ueTcq3iV69A9ZHyTOwQ/tlW8Xc6iflKqED/Z7v9Zo5fx3tjDhL7examAkUMiq4ILiYH5v2QsM/6JQajBgGuYBwTQINNQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;7:wv5su4CH/B8wlKsN/hHZpYev0yqmzxkpsp06Uc4h1ceae01WTIIFVvDvb6f7ON1iSZXKSUFNdnqF/2pF5mhz6lhq+iGBYp7u1EgzbpIXyt+PfN8AQTLpMV53O7WNpW6iVIYfxLGko9KjpYjlx6ZyOqKmN+igOdrNwFJUfAKRl9Ko2olHUcm6ErBHTf6HaM44q1KeivnVyUCHIucCedgBVSwCPVYFC41lZu/zTQR6CPORiTAKprD40ZbhWjnfU33j
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 16:41:40.0213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a419a1-af21-469d-5d5f-08d59338732a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4450
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 12:11:38PM +0100, Jonathan Cameron wrote:
> On Tue, 13 Mar 2018 10:43:55 -0600
> Logan Gunthorpe <logang@deltatee.com> wrote:
> 
> > On 12/03/18 09:28 PM, Sinan Kaya wrote:
> > > On 3/12/2018 3:35 PM, Logan Gunthorpe wrote:
> > > Regarding the switch business, It is amazing how much trouble you went into
> > > limit this functionality into very specific hardware.
> > > 
> > > I thought that we reached to an agreement that code would not impose
> > > any limits on what user wants.
> > > 
> > > What happened to all the emails we exchanged?  
> > 
> > It turns out that root ports that support P2P are far less common than 
> > anyone thought. So it will likely have to be a white list.
> 
> This came as a bit of a surprise to our PCIe architect.

I don't think it is a hardware problem.

I know Mellanox and Nvidia have been doing p2p on Intel root complexes
for something like 5-6 years now.. I don't have the details, but it
does seem to work.

I have heard some chips give poor performance..

Also AMD GPU SLI uses P2P these days, so this isn't exactly a niche
feature in Intel/AMD land.

I think the main issue here is that there is some BIOS involvement to
set things up properly. Eg in GPU land motherboards certify for
'crossfire' support.

> His follow up was whether it was worth raising an ECR for the PCIe spec
> to add a capability bit to allow this to be discovered.  This might
> long term avoid the need to maintain the white list for new devices.

If it is primarily a BIOS issue then it should be an ACPI thing, right?

Jason
