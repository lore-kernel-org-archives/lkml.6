Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753463AbeDLVPL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 17:15:11 -0400
Received: from mail-eopbgr40090.outbound.protection.outlook.com ([40.107.4.90]:53283
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753105AbeDLVPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 17:15:09 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 2/2] ASoC: tfa9879: switch to using .probe_new
Date: Thu, 12 Apr 2018 23:14:32 +0200
Message-Id: <20180412211437.21599-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180412161601.GI9929@sirena.org.uk>
References: <20180412161601.GI9929@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR02CA0105.eurprd02.prod.outlook.com
 (2603:10a6:7:29::34) To AM4PR0202MB2770.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;3:kc+CAUnU/erMNK9L2r3RUGwdGpwjbB4Dbb1zOiDZFtHS+f0qeQDBNoBDTbFxA8G3fp3yTtaCDgdH0MpX4tbkWAXZQL+CKMhEieqw8XiMAbFd/V+I0ci0JF23e0tR0QFkkAz25h0PTg4vinKajFY5RuyZygWuOIq6aM0QJViBJ++UATKAKO4TxLbdw6yPfN2Uy5d+4+WOPeNT7qjp4W8uLA9A2+qZPf2AlzskL63wEmSFT0/FUiZN/8mAEL7xU4Rr;25:6Z2zjV+pbciLRfw0THOAJWNacvdewymzoPkErgMQzo3r7W4sfS4JSNKrp907GhtamxyVp8zNqv6pw/kPfYHCgaTBmYrENdspscLt5C5o10Yp+W2LnGrazol1ApDRhggR+Q2LJg/Xxzdwya/GMUJrJnt3hV0NYSQy6rx0Cs+b/5Q2PDaxnj9s49WedYuyEv2ylBD9He6PHZxSoBeW70/fXwIDs5PjeBia5WSootF5OCNl031lazC+daJHwXFfuFjpr6dtA6q11bfHayJQqDOoWv4w01lmSHbtWz4yRQ0uLWgoT8ZrdHMbdLkH/K1it6XPnLSeQQL+PhTTuMmx/weduw==;31:rXwYXjjaKfrk0mqALZ+Kb3zOepBxl22ZKJ8ULWXFtIENH6fPY94SGAqonyMiwQnONmdiBTMlFXeorM4vnqml5FYZRfR5pN0ReSZl4/fdV9WLuhgqULHRi4IsTmv1BflXk9qKoqA/ACViMIXOi2Tly+rZysx+WR+1AMviOmiHSkDDVwGjzlIesmshnfZYIas9pbceRbuXOllz2eyhnHviY4/C3miL8yyjc6l4j2XzCVE=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2770:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27705D471D0DC34E29186E06BCBC0@AM4PR0202MB2770.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501327)(52105095)(10201501046)(93006095)(93001095)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2770;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;4:sxVKfe6RvhYOVJZPEeDt4wzWBjc2dxO5iggS293XD/A/iOolZOJ2S3u40RwHQ/dj8OWSNo4VV4esZHJl3Ny3p7dS2X+45Z2iBlE6u6xCLhnCyK0qwju7fnqZyUsZNbm1J1K/Hygl2a4pe/fAYBjZBkvVXsgIW60Q8z4dfSSqfGS8LWx3aPOKsC91kKqfTvnbjdgdUx+zAoq+dFa9pyZHNHGr6ARcoFtJs2+fQfQyrhPUKfdUanunO6z/uC2WeXFvdrE06OP60svZob+L0SXUOg==
X-Forefront-PRVS: 06400060E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(39830400003)(376002)(189003)(52314003)(199004)(377424004)(97736004)(6916009)(2361001)(36756003)(2351001)(68736007)(6512007)(66066001)(86362001)(11346002)(2616005)(2906002)(6116002)(7736002)(6666003)(47776003)(478600001)(1076002)(476003)(486006)(956004)(446003)(26005)(54906003)(3846002)(4326008)(8936002)(25786009)(6486002)(51416003)(39060400002)(186003)(316002)(386003)(53936002)(105586002)(74482002)(53546011)(16526019)(6246003)(16586007)(76176011)(106356001)(6506007)(50466002)(81166006)(5660300001)(52116002)(305945005)(81156014)(8676002)(50226002)(48376002)(229853002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2770;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2770;23:izKhczW8mmFnCMXj0QkGDBZSaO4xzve3qNUi0Va?=
 =?us-ascii?Q?4W5HDuBa0bY6RvnacyuDx4eRiX3Vv5yVd6qq0n8YqpZW8JEZVFsuM5dvn8jv?=
 =?us-ascii?Q?IzhKV/cviPMZfEuH7u2svWcu1QaEVVCcjKyqIEnb6gBZDsXkuF/uwr5PyGhk?=
 =?us-ascii?Q?5EnzLtNM/mFk2YIKxW+FYtsRu6YAbze1A9Mu13fqac4kmR+s2VmZlNx42mAF?=
 =?us-ascii?Q?w0rwmeg5RadoqbjOnfLuhrreQpfg7bfTYxCksf1ctJCpbDvIAp92nSzzd7Al?=
 =?us-ascii?Q?PryMZFJHfQSJ3JuIteBCn+nl9EgB+CAUwygLObZL/AiWgCTlZCqZevPIA3nA?=
 =?us-ascii?Q?9FZwVOBiLdakvyYKQnvp+EtbFSclKvHn6qHraQjFjo1Ce4pQXSIVqoZE3Xin?=
 =?us-ascii?Q?aPLNcYD5pGxZrIoG429tc/3QxajyzxLAoaoKZ9MN5uxM9fSZMt6hiYC0vLfH?=
 =?us-ascii?Q?TSrGUboqBs0lNGIg/v84clHbjm57nPdyLtcuPbBkaxEasds10uyi7hf/l/Ut?=
 =?us-ascii?Q?n+KhNw8vU5j5RwNKz7rs5WjXs5hNYKLYlSBhHZgyhRyai8UnyW9Q2izZ8igL?=
 =?us-ascii?Q?/hqFs4wBu0tnUNua4YD/SXL2XEVRnqSNnsmez+k7z7WSOnscuyoCXd/mLWND?=
 =?us-ascii?Q?636WlIyNqh7IY4wVaUE+uBwZ+fG+HybsmcWR6U5mUCYsiLIYIIkLxGoxuCPv?=
 =?us-ascii?Q?9G1my0WRZXiv/AJjCxFaupGpCZERypVmtL2tC8Iy/sWiwKjSae6qyWGFHD5e?=
 =?us-ascii?Q?3wXSGH90TQFP7okE21H5eFftTxml86Turkq2Sh0jSPZEpdvl5oX6WiPhaifO?=
 =?us-ascii?Q?gnHdtkwq0u88Q0nZD3ZtRniY3PIlClXafrUOYLotEd0g6+tUTkSzw2bj6S8U?=
 =?us-ascii?Q?k5ZiIryjYQAR++5WxROrpWnp4LVT0jP3AW2a9rrCw+55OvbY09CNyk8VUWW/?=
 =?us-ascii?Q?Ggm/qRVBMR6OR8N3LDhymRkQnWcmVmroEC8hzzpLx3/O17G8OQ2ETon5Cyxn?=
 =?us-ascii?Q?vGWiwpL54vFZDqROkl76Q2LmkWlMw5E1ubVKAKklaYkxLnKdy6/ceWC5t2o6?=
 =?us-ascii?Q?H90Y1JlnC32LIqD6ycst1Sf75wPDYsKpGT+PFdJMfhvFWzz5aEFGJdtSMB2H?=
 =?us-ascii?Q?/mIyV6thn8p1dj1r7auH/++dFTvRFqeqGqVyuKODElPOPvoMoxT1Opk93qly?=
 =?us-ascii?Q?H9+UOKtH6hrwLK9uD304y+JeXrV6jpUt6euB6TBn9LEcqcLYyizhi1+Nsvda?=
 =?us-ascii?Q?KLMrPTtJ3FBOS4ZlWDl/d0oO9Zuup83p/B5QsEregL7F1lZv50G2wDjtYe7U?=
 =?us-ascii?Q?DB5PIFwZ/M7GCK+ThlQ0D4flMEvTrJVDPDha7t/m1nPot6CKbSu5h5LI+nLc?=
 =?us-ascii?Q?wX0YpS/s1J0Q/y7kkunoWfIFpeqmWQacHTywxwivhJ2VkcrWbQtvLqlwGfP/?=
 =?us-ascii?Q?BXeLUaQSwLkIhU4H1TD3SvLEaiRat7chyOeEQnIhqg9Hhd81QdD5l?=
X-Microsoft-Antispam-Message-Info: XnTneBqstW70+7QjeI/BMN1pZiDMfjqcnmSsV9tZsp7dz2xUVZDKpeIqbbXnp0Pf+T8ipVJjgL6pMPZ+68QqbWb2hjSciyWh34IrjQS4l35xtkg5CYLjjQXb/DjOr+giMr/+c82F1fpIQ/w9M++yMcULOySac9t40t0H45Du8mxUwsnECFFGgIbA43gIeuys
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;6:nZw4guZNYVdCJ4VLjXqFoZHT4n9R1BbOm0/2FQswydmmqN0M3WcXS5EKwwzVp6gmkeN8tdVcYn5nbLXijO4Knxl7x0IjIpdlbqIqS904aDJ6oFme/MV8nUkdMWcm/grDWU3ooCY06SYjxbPmlXhgL0Jt8AKQKMq6TgQJYOu9I40Q75nw+VGw0W6O5hK5t/Q6OYpoBZECRFR0uhbQ+1TNvDwaeJLilXX7UHFg33k+i3aeYSaCCph90qGpooTNToqIqsPzO0Zg5i6vbOLJmtIQDT7nuxpqUW1tELRMn00Pmmel9St68MKuHSyTwOxITkFcmrT316cD6f+H1MMHWs8iNb+rcypmTGUT/vHZS/IT+5DlRazJs5v34FIkpPHvWEn5KSUjRNm0dL/LSRhhSs9fJxAstfHTjhzUdfI/i/7U3/tgU7c9fneFop7c0iNH2o4/cbZMlXHmN/QD5U8A1bli0w==;5:KGUTUeBXg7wF69gNY0cLklpevAWHHudChtXVJ+OHU6y1j1jBAIDrJmrBx2fcuJaQbkl7suY99jxntgXWQ/40IBF6TNF6mcxQhGwEtin2O4PKg82vLHvRhv0O8PpEa/2shgOIUCgUfPf+57KVeQRfVoaEBpHv78KvMxCx1GMXypM=;24:Xy80m7ejIrKEdmcQc4kIdwTDiQXO2H7BJ6Yd54nPCasRfk+QqczcMp9bQeuizlkPYUezxhqMh6ILqAG6xKdeMVDiB2yC/6BX3zPn+ksgpZw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;7:JwmtMKNQGRvnS6B+ZMenDxtmdCQTW1ennpFosxBjgKOPnvD3QD0WRwn9RJgfN2lGq/FIEKVL2ea9uJ0Oj2Ia9HphRZlLJ14AX/cB/9dlz+dW9Jn8R2+pJ8LQ66cfi1kRpPBzZP3DzMEct+G+dSQmBuokx00mf9AJliSb2XYmD2/ZxQxBgnOHMA5GNUHxAApoT77HKextzMpPy6aKxuXXcuGo43Gjyb/OnZmslrKG4cu7mvRHIWNZhov9hIc5ppyq
X-MS-Office365-Filtering-Correlation-Id: b7206b22-3544-4bca-ddb1-08d5a0ba76bf
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2018 21:15:05.4127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7206b22-3544-4bca-ddb1-08d5a0ba76bf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2770
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-12 18:16, Mark Brown wrote:
> On Wed, Apr 11, 2018 at 02:42:38PM +0200, Peter Rosin wrote:
> 
>> Use the new probe style for i2c drivers.
> This doesn't apply against current code, please check and resend.

That's not my fault. Somebody forgot to drop a note with the maintainer
so I was completely unaware of this change. It seems to have been a
cocci-script or something behind that change because the code looks
like shit afterwards.

For the record, I wish to be on Cc for changes to files I maintain.
That is one of the core functions of the MAINTAINERS file, right?

Anyway, I added a couple of fixups for that mess and I also did a SPDX
conversion while at it since I noticed it was needed. Finishing off with
the rebased patch.

Cheers,
Peter

Peter Rosin (5):
  ASoC: max9860: fix whitespace issues caused by mindless conversion
  ASoC: tfa9879: fix whitespace issues caused by mindless conversion
  ASoC: max9860: switch to SPDX license tag
  ASoC: tfa9879: switch to SPDX license tag
  ASoC: tfa9879: switch to using .probe_new

 sound/soc/codecs/max9860.c | 18 ++++++------------
 sound/soc/codecs/max9860.h | 10 +---------
 sound/soc/codecs/tfa9879.c | 37 ++++++++++++++++---------------------
 sound/soc/codecs/tfa9879.h |  7 +------
 4 files changed, 24 insertions(+), 48 deletions(-)

-- 
2.11.0
