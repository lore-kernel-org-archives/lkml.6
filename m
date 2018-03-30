Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751223AbeC3Kdx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 06:33:53 -0400
Received: from mail-bn3nam01on0048.outbound.protection.outlook.com ([104.47.33.48]:57073
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750967AbeC3Kdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 06:33:51 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Fri, 30 Mar 2018 18:33:32 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: David Miller <davem@davemloft.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] net: mvneta: improve suspend/resume
Message-ID: <20180330183332.3e180a1a@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR01CA0009.jpnprd01.prod.outlook.com
 (2603:1096:404:a::21) To CY4PR03MB2630.namprd03.prod.outlook.com
 (2603:10b6:903:75::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43aeb5e1-5123-4cbe-fdc0-08d59629b95a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR03MB2630;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2630;3:neP24A2Onh2w5BW1ozue1XZgGxTJZFUMZ9N3cJ7EbuK8hUrnZzn5ISXzl/DVm1/N7lGQCpaMkBDL2wPhtbR4GS4aRIUJyaCC5MJ+gjviv4Y7YCSEjD3ptiKOmuAoIKP21T+Uav8lBVAiLghU569CeXCa05iDrhGNOfedhCPTFYOF/CzeQBon9PAzRMXZvBPicGonN386ChMvdVhieyHYBCcnTCttcygyEOM1sOjIOiVRo/SEXFKS7vhYiqpM/21o;25:KOH0o8AhMDjPjo5wAjeUepCXiNS37smnZ28KC2C14PqQC1kyQ4pqTzBONNdzrB39P4qWWW+gK/2/Rr2IC/Y4/D+uhFDPeGeBNV5NWSlnFbXHfj62yNUJFzmL8O7X7IFzEQiMflIZ2Zv+eVIZq9pQu8Zzx9Cq08j+rj6yycrastc7fGpdqDDdxsBugy4YxABp2tpQ9UczFEl8TF5ftbwu83f1kDXJGNwy7gI7SivKj0hPFvVflGy9tUGamN9wJ2QVhn9OvNfGZwr8ep+vbDbfklw+QCEiGC2FY0lICIYojx9Yg6SWvUZk2javtwjJC4HHGiMkxdW473QpnHtAOA00gw==;31:MDbD5mtTWCwOAka/+HH2HIRH8eCJU7h8mySY93JKzbxod5o9FYOeOCiH/1W1IL4lXSRRH2scHsgsiWur+V4MGXcrk3jkjN66sNrg6lTvOYmFxntcc4YW/KrlzRPklH/A0H5FbT0SgHVAvJ45vDGIzCR+Qi1GB73r2VHyFTnEDHPp0M+c6onWRYJSFOOkCjniphil/jr4kEMVi4tFb7q6Hvt1xlCwaQTDhZXJAl+eizE=
X-MS-TrafficTypeDiagnostic: CY4PR03MB2630:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2630;20:Vm0VfRYVTH+9K0vSLZkQsTvpmQa/Cae0U9LzN6DchbOkODuQcKLvn5QncXEvzhRO071Du1DyB8D9Xot/nBJbc/aqRhO48iLdkyqrDghAiFX6Lc3iQyclvbtn/DxeuAImVEMx01XYXUS16YxNakwtVqOs+TRNLq54CtrlaR5DtIhoKXpjplotPrxrNlv4rnVoGv67yq4ybwILT8wUp1J7H0w4SCYegX900AKuSS9IDvs0mPSW5BZz4FuZBA90rSfyngK6lA44fdFTvSbZxKAzV6inkKNQA3COblOQ3iL4Bib7J7UlgJ3qzitFVTNDCgN7K4I+nR4Tjci1QIR54CaIHqNBjjfxTxR3ReegnDV6OMjsuj6UsOQAfYRrVcZu1adk6C+rBJHJJabR3+TW2636lwpMU7SLdua4SN0I/0S7Z0W9MfV/AbrZoa9Ac6zWvXgYHZSXsYKOlV4wwV/R/s9hKPEBoW+Fja1PcxplfCLgWutWdrw/J6Luava5d+IxxrBW;4:7CcQa6GInPbTrcVaAdKrIcfdY3e5gcBt2cj0Zv4xMkLFAln/LwRWqGvCy0wU1NKW8ISwCgSBHLStGgSl0vp2dMhBvoO0QZPIbtfkg4h/WJjJDHUnZMxsLc00NCMtOnSGVWX1z/+J4xMXGQkF2ngwM1ebgnElhvnpSvGtf8daFkEY6Um0vYiqlXkrTqm7GyN6GErWcZZdxbp2PZuxQo7l+i6yXuI/i513s/nnfHq7fe1mdyZCtEeJEPFBXAr5BHkqPzQPDTOFfK4Hrs3wDwFwiQ==
X-Microsoft-Antispam-PRVS: <CY4PR03MB2630201CCAD0F3A429AC55CAEDA10@CY4PR03MB2630.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR03MB2630;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB2630;
X-Forefront-PRVS: 06274D1C43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(346002)(39380400002)(396003)(199004)(189003)(81166006)(54906003)(52116002)(105586002)(110136005)(97736004)(7696005)(6116002)(23726003)(230700001)(3846002)(68736007)(476003)(81156014)(7736002)(386003)(6506007)(305945005)(6666003)(50466002)(956004)(53936002)(1076002)(106356001)(16526019)(33896004)(2906002)(8676002)(5660300001)(4326008)(59450400001)(9686003)(26005)(86362001)(486005)(72206003)(316002)(25786009)(47776003)(50226002)(478600001)(186003)(486005)(15650500001)(55016002)(8936002)(66066001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2630;H:xhacker.debian;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB2630;23:9Fcs65D3njyAhR9G2HtPjwj55qB+ZuK++KddgrBGy?=
 =?us-ascii?Q?WJ/9Vjvh+bIhJWem8Q1/iAQjuO12TNftLHi1p2+D30w31wsbQyRc1VNy5An4?=
 =?us-ascii?Q?qHly6YlEUGVVyuKeV3TLIO6NeUEXSJLA4reA0rVd/A4B9bN3StHMPignk9DA?=
 =?us-ascii?Q?1cgipGxit8hzjRMq602ZTInYt9LkxSiDD9pEquwHWbEkEkygVV7pGWvOZO8e?=
 =?us-ascii?Q?6CFCMC1YsYGJ/GPuREMzdjwu/oId6ElMZvKrF+36P1CKLK7ggUj/OvWTsO+G?=
 =?us-ascii?Q?51ej1qOY/xmjImJol4uMpu4+cM5GFBvMengUmGwAs33qhHrATj8SMjJp7krq?=
 =?us-ascii?Q?c7uQiTgyMTjZvy78jnnyLtwm3ZXTjDoBcxk84O+TbsglzFR87OUtZ+IJ0/lM?=
 =?us-ascii?Q?4VfkvaWG2+bs1j1Grj7n9LGm6C7NnyAhIrBnP+M/8pgQ0qiB2fjABSNhPNwa?=
 =?us-ascii?Q?hbnGMsMX14+WpCyf/mzSjYkPpkOYp2QUWVK4lV/kKRGR1B6zvPBjllZO+zHY?=
 =?us-ascii?Q?b7QrQDZo9AmLEalkTuMjjn2ZhkcRCyqJVPfD656I73w2DrkKtkKrRX6ojcYy?=
 =?us-ascii?Q?6ggMU72tor/VmPOuq/ZbWej7kTEqZPPrfIJtGUhlqEp12jc4Yb3p7XcRR6sQ?=
 =?us-ascii?Q?zJRJWzCM08waFbCa2yFpCW1QvXHlK04FUZ2TtCFi7T7PqN8HGkQUjQe9y1Kx?=
 =?us-ascii?Q?O1U7PfwkY9QY29q6He7PLJi8GADZa+N+puF6lY8/wTVJhpORxE9MfQLe5PT/?=
 =?us-ascii?Q?D9w49YK+BDFpiAmZ7WRZbr44KnoA0S2FIXoLAhkbVJlvSpouIEqv0Rmo9Cu9?=
 =?us-ascii?Q?R1lQR/RMGfnGVHKv8wjgLBOCS7Wx0YuZ3EWKl9R+JGLSiY/I+HfhAvuV6SFW?=
 =?us-ascii?Q?s5Z5iU5BxmxFTB5Bs2rJVHDjY8ZQmj5j/j19JBvDVew5ZATYAmmLxT5D71V3?=
 =?us-ascii?Q?BgeeF4eVZ82E2Uh74wDw5NujEF/iF9FnOT5KCCHpmhFM7SotfVuRcxtS+XDn?=
 =?us-ascii?Q?DzzeYZpxjNv/oscM7Gs57WC+qNyF6p7/zeypynbvmAhpCSP3tnX+jo1NncaZ?=
 =?us-ascii?Q?mIc8FYeCm442yIuItn1JKR/V63wN+X0yb9w/yVLUTJkHrIT0XxlikbUK0Mds?=
 =?us-ascii?Q?G82/65JStwDsDBTB2NHQAYB5Kl90VFF8SwWyKeyjZwduTXQtOfGcWveyUQ0n?=
 =?us-ascii?Q?JOSkjnu5w4vie7t3JBFVawHXwfBa1p67qqTg/oi05KAkrY9xuFhq5a5zZr12?=
 =?us-ascii?Q?6+8NfA2FQJc888ui/tZ3xgVME797ipUPdAPNgjK?=
X-Microsoft-Antispam-Message-Info: xezM64j9jrvYb9q3OAwJ5ggBi4StW/7KpZcym98eFTtVl77zENbKzbHrbkPibe7F25c2uIBb4An90HN1GpDiMhkPXY0joX8SYkuNVbgfNbOxwaCcuyFcUAOpzx78gJzBdCmhh0rk0ueRn2x5wUhPUb4HWahv4ayKge3l0RYU9Q731mNliSZ5SZbObmRkGsio
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2630;6:lufHaPMmxuYccZYNaqzDzW+LpZaSkhS7QZ7wgGWRE5ODl0jWBe8OewHuM2Rsc81xL9OoNpweZHBoaMXfTH2HSjvDiyF2iR/D1GDop2wLAjtwr9jacnqZ46O8U5uRKN+Joo850ClkKkBEfjM5FcEsIGVStwW7e+2Kt1aoYuaoeIl6Ofogf649LKbhpHTea2HP9iX+aEOl27WjFqKGywFh3/IflwF8HUI82AvtekeJ/1BinSwHbmvUuXW5n1wIJlV/RUuhK8vAvo6BkTHXulXEBGuSUqChj8FeXn1vcT+4nvOUcW8hqXkwRE0bC/lp1NYSIx6oeOBjvRYKDhHkY2IVWfWZIdDz1e5ToDb9i9EIT8L5E5ukk8OB9SgnxeuqVahd/pNKl1bSnyao6vf2T8ALdmtawXeyXkDpIVakJw5BqsdbMJbd/EByA8SsVJyOBC73wW/p0kkWJ2MDyjg6AyPeWA==;5:0KnIziiK20zS47y8cz8yJBbpfCsR0cbt7EaabN2Y37ES2PI7WvYDQqK/C7jSXJAMLLGd6ERsE2WAQVcN9dSS8o5QGvmUhQ5TSc+qJ8pdyrhTEoEz/4Tasi6hFZaDbkZqfmmHcXOw3WjFvVzA/dzdde+ZuAS33yRV7nE5wenQa2U=;24:POnWO55YMtlxyFbqJofiPp4X64abxlozWGCYNjXNJ3Dt56Vz/rmXmIYT8jaDc8AKY3QDarLlSb9/RkRmhyoL+1mihIZuJ1H90M5FG9KtMpU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2630;7:njwvYqp6gZiiT4Fjk4ejv/CDmInS9v6QXLL9hRgRasRecP0FgJOWDi+oZjpOCTszhdVx8xT5KJB9Y7NbykbLGcm971bu2HHTZMbGNGu6jqnLkCJK5sswWJ/4Au/lYDkU/KqdFa+Cyb0u5J0gbcbVpSuayKssIIMFDZTuQF4pILSKQYnuefNyjZtypnFhmATCERqDIYj/ilpa7DV2dVRdLnclvodJ2pDQeLz+L2L3fcbhAHt302dKVAxzpGVz61m6
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 10:33:47.5991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43aeb5e1-5123-4cbe-fdc0-08d59629b95a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2630
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series tries to optimize the mvneta's suspend/resume
implementation by only taking necessary actions.

Since v1:
 - unify ret check
 - try best to keep the suspend/resume behavior
 - split txq deinit into sw/hw parts as well
 - adjust mvneta_stop_dev() location

I didn't add Thomas's Ack tag to patch1, because in v2, I added new code
to split the txq deinit into two parts.

Jisheng Zhang (2):
  net: mvneta: split rxq/txq init and txq deinit into SW and HW parts
  net: mvneta: improve suspend/resume

 drivers/net/ethernet/marvell/mvneta.c | 156 +++++++++++++++++++++++++++-------
 1 file changed, 127 insertions(+), 29 deletions(-)

-- 
2.16.3
