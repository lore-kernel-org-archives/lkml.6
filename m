Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbeDDGpa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 02:45:30 -0400
Received: from mail-sn1nam01on0077.outbound.protection.outlook.com ([104.47.32.77]:10368
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750852AbeDDGp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 02:45:28 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, bp@suse.de,
        rientjes@google.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 0/2] x86/CPU/AMD: Add support for Extended Topology Enumeration
Date: Wed,  4 Apr 2018 01:45:12 -0500
Message-Id: <1522824314-25345-1-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR11CA0029.namprd11.prod.outlook.com
 (2603:10b6:404:4b::15) To CY1PR12MB0134.namprd12.prod.outlook.com
 (2a01:111:e400:50f6::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5ea717f6-79ce-4e5c-a634-08d599f7a534
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0134;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0134;3:Tigq9wflu9/sDK7aLF+oAzAWlffPV9FGGQ7ruzyNBacZbXKpwpwjdX9Nt6XzFVF9sntTGECn20HjjNU+zviR50nmsbzBYz1lRLQ86gBoQPYoisstga3LPzSX34Ss+ksHb7oLbu94BEFlcsiec2x0OZ2ePJJeAn5A9eiM6kTgq0r33nd4SLWA+T29xdzJm1Ohr4SBSf7y+wS/hp/CBaCQ2rbln9y/MUVrvgo+ozBs0P5Qspog451BfHJ2JB3Rubm9;25:l0Wwo5cgdkv0Gb1uPU7EubT7dDQ4yg8hI9BX5msWTym9aYOiilkeGQRGdzcMNoyS6dIDCO4lrCSMo9+quYEChwEWkZ8VhY2p0utS1hD4v+TYoluwQ52/3IXSbVUeNJRQdCIwVvLqTduAo7LlXXMVhQN1ojm37qRRIPGmIKUQYRs+p9vVw4MCIXglHTujG+5oQO6eCKUwweqo3B5gDwXrQmHng5n81P1tLdOFvYf2zspFtSrob9HjjmKOwrildUd3GUxPbxqcXo/pyxF7xCMWGMjXJEbI6s90SFtjN+eZ6rT6o7Pe/I4cIUTWyeLZUVm5aDezOicOZVxASl/IkFA+mA==;31:xm01Wzvq9+ELUpNS9/MsfN+UP++gtKmXvH40mMPbgmqT8qZd9QpggfhDipM8Ui3VpoWUkkvO67dK9LIE+YEreCsCnfLjaJqJh6piTDbmRDdHhT9YjrxoZcZk6mlNvWTCtMOxHKA8tArLb64Vkz7cEUuMwWBmRBSJF6+Ffkj5AN1CAIbeugniJCNViBL5pytTQXkckRgZKSEThFj163rh/P9ysJpaYvwqR0YJdXLVOZQ=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0134:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0134;20:An8gBSjGZMRgDZfOkxzhw+kdH9Ncm63q7Kdnyc4fC5oZkBABfD29cI5D9utQhYfOqzCmxJ3Ng09z2unY0FKPLY1HpFm6+85WA0m2b2suS+r6d141ms0h4fEn+/Y6DmF7Bc3lYxO4wMiR7APXSR3Ok7uClqSQOYOEB8SUzd5ZU9laBt8Gux0KCulKHGxWBnmQje5RYu39pC7OrHBvmbIbIZ6a8ghVOL6PekYE+EBR6VZj1krEAlbN0ZpZ41Znhki/JRgMrMCYl6/auH7rMOOWjnQcE/TqCU/z3syZvAJxzdAWPwDHES4u7vCf6py8dlKhRy+P5ySP0e/2Av8U59aUEQ6WrDITFYhOI27fZSrnaMirm+4OCLJTm9lql6GOUE4H6Wr8ub8qfs4Tr+W9WCh6KeopNNLqdpeBoiUe2ksZ3CZEF9DF9g1SFGxKOP4FchChLL2bsNvyNVF59af9NQHCGKajxwqAaJWfnR915ullHkH0zt8i4Ma53N+MYZl5d/VS;4:QFACLKYPM3+afrj5xeWU/3lE0bPaLeGstCsUrkwzvE89RU1PI+YaJeImw5xDMSmXz3VdpyEM5QIsLN0ynb6S+PdAwf6RIun3vFxb5nEqCEfQGqxiUQFlG7y36mKemss9MSdBOjnKjrJDeBKst5AO+ARXOAJA+tp82vzqBoWRBPP2k3EXmcc26lf3PeOnJ10r9K7mwoteadoKC6gwjQtKbPl9FZPtSM6NDTWTX3JCTg+isRDIq3Sx6w8AoEYxo/JgzPTg0prCjo40h4A8xo+csw==
X-Microsoft-Antispam-PRVS: <CY1PR12MB0134C4A520121903F6222CEAF3A40@CY1PR12MB0134.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:CY1PR12MB0134;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0134;
X-Forefront-PRVS: 0632519F33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(366004)(39860400002)(396003)(376002)(346002)(199004)(189003)(47776003)(16526019)(66066001)(52116002)(386003)(59450400001)(186003)(316002)(16586007)(6666003)(7736002)(68736007)(486006)(51416003)(2906002)(7696005)(305945005)(4326008)(25786009)(476003)(3846002)(53936002)(36756003)(81156014)(8676002)(6116002)(106356001)(575784001)(8936002)(26005)(86362001)(81166006)(5660300001)(478600001)(105586002)(97736004)(50466002)(50226002)(6306002)(72206003)(53416004)(2616005)(6486002)(48376002)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0134;H:ssuthiku-ubuntu-b2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR12MB0134;23:GPxtEA0TiAORA6nZLT2o+IrjrggGN5XPRXhqK1M0H?=
 =?us-ascii?Q?OzA614ctJbAXkMt1fn191yhkBEQhxD67GUWqDhnKYXnnDfJOgdMJ4LONJzbP?=
 =?us-ascii?Q?svkGcq+yrlVcSvyNetE2yjbiUX/FGXBiaqugz9sAH6rDQEHZyWesQeSSaURC?=
 =?us-ascii?Q?H9qMCtVFshPD6wpz/CcESAuR5rse/7Kfe17Tnqk1POB/88Y7UM7gfjMyDhRp?=
 =?us-ascii?Q?hsTPZ5FT6EzhVm4aPCBCeshepNbAQz0IM2lnvviQP7NWgnn4lqLD8J+pIFUs?=
 =?us-ascii?Q?JwguHH0I9vgJOmjc0dhiv6uFMLyBQQI5GpoS8fGddtFC+F8u849k9B43Chlt?=
 =?us-ascii?Q?/9Di21AJhHRZL5QvNvRRXfUmFL+ZA77eLFjDGHEPJNLYs35G/fevUlKkw+CV?=
 =?us-ascii?Q?jcUVtbD6cL02wtIahp+xwnkq4Nm7KGdM/YB8j+zP3+uTPakKuOT1h2He0vpb?=
 =?us-ascii?Q?J49kblpNNIQooFvHDXChkFFiDmSx2bJhSELqxpTNuEjdZQ9E208ZgPh+kL+W?=
 =?us-ascii?Q?VaXXqgSpDHBUe9m8eKee0sruBL0oN6qPe+sGgnmZD+IKCTPT1ZhR5lhU9koe?=
 =?us-ascii?Q?r05TfKEEqC2fkOw6xTFYUe78UUT2FVNv/xbywnN7yR/KasJanqEV445Qpkau?=
 =?us-ascii?Q?1DJLpZR4jiEs4tH1UgLfpbXQs4h3SSOm8czxM18XvV2EPjc+Ys/yCf72uS2R?=
 =?us-ascii?Q?tkDjB4XuMdfVF4pCrH5e1CyKA8OdCtjqSZ7zlaQkLO1REumedEKMHJs6/MjZ?=
 =?us-ascii?Q?xK/tJqJcOhPIPlks13vB9jCMEy/ZfklPGks/ChY19EEgU26zS6mFiHmuPJhJ?=
 =?us-ascii?Q?TmJNw9O414SoU1byx/An5E7Mo/O5d/H5m28UpDVBKPQ8vFnXjWttjiIrKoWD?=
 =?us-ascii?Q?XiD/sy/itvKe8YfdV8a2GV1tXF0v7y5ZAUQ1/zNorXaaEReysB2xYDB76rVo?=
 =?us-ascii?Q?dheBGbcxYaDOnpzvGctJTrmG7ZEry/2Fu5xJzRTzi/7IhzPtFa+G//qeJOx+?=
 =?us-ascii?Q?bI66WFtai+g5HnUsDFWY2wWQ8zTmLZUwf1F4SbvCGVMdYZDuRm6pMmptAuLJ?=
 =?us-ascii?Q?t18ll8lkQpcxbCuT2DhA9TEJX4IQxw9uEB2+g1vZvPQuBeb+98O4D86HonqJ?=
 =?us-ascii?Q?8GLQ+VEOE/+XuJgJvIEr/mlIg7QcIHuBMqibdEpaye5xx6zcUtBR5OGTXJJl?=
 =?us-ascii?Q?FcnoqKsf0rhx78igX6fb1cZKhBJst4KTzru?=
X-Microsoft-Antispam-Message-Info: Q9CCqrnHEWmS5/lHhA6ffaU7ZOU9M6Vh3KGXrAlG3biH3AMznRVgnbO37mN6LQplMOqz7q6VIgSdP4ZugeX/TUr4l6FjUDJMB9TuM73020rq7aG5tfZFrgsOVuZ5qkT+UFJlHpiJ/q6PcPAs5wN+dRDe/YjCbqo4+jyAuMmOHd49/rJp75gGaQNGzBuouTK4
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0134;6:HmykhNEmA9h29rjP6GXnTolciZszMVjtUKABWotj+Vr9NQK4hrMRKDPVr4YlgR9DP8mzZ5a4/h7aiLZ0zo0767cmR1A1FXlqCoxyOrrxPjs3tdLNSVhbnvJ2PfsgkH4HAW9KLHNRiAqT9Y1LkrbpBdU6M2K8nmh7Zw/xC6INuE4LmT7ZZ0YOQc+hueNPXZ34f76mabYuA8G/eb7/rpkSaZ+aS9KNpuLa1yi7GXv1cyaZJKJXNjrGwyOEtkUxmAyIvrroTGhdHxchj5Rsm9bAM8u5dTNsPevkRpR4wxGMmCAdu2wDr7Wo7/7QU1YHRk8MGuyvliaUseM///TvRkDFz1OTjeXUpQpiSpSSV+QzB9A0do/wSWM9IhpRr2wZ+h7zx0Yi+U8gGitKWaUdQ4+QyOUwVTsb0YaVshuMSG0Zbo2MeuKmsxapRRv1vEJ/+ZV75fmuxkcZZtPf78nPQKZxmQ==;5:+K7yEsj0kupoCk4eo6fdgOtJ14WezmoVyBeMa3eAXgYFpmUaWST0r9stnO1MLlWlXVZhvVTBqFsCPJdquRKTil9ODSHWqtI9ZMO+s3P+KOV38fGQij8KEnBS4fhfZvgU1Oa55p6+DUd2lZzlrZeUQYiakxwp0TfJk3SEBezXsb8=;24:UEZLai6zPuG6CT7ZXGgaYP/Ef81xwkm21Mta5BDrZzko0Lk4twLRVlGrxcpK040LUaHc+VdlwujmxFYQPQgPVvO/gdFnR+NnxMVeKj7cUc4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0134;7:Cc7Ck61xiI211aL0CXgdkprcWZrwFFI3kODp6fDRhts8bRVIwL9+FnT1I0fHd+i399T+fd15nJHy0vgEQN7rB+fOlOnX4iyg9p9WhWcm857uOGQwnM0/RLprSDvT5hdcxB/uX/BFHe0WWyAb+XjmeewUBnVGmLTjfqOtKT7aQI/tmJ7kRkT23UD0VYEHKQjx0CY/4bHTOlAeTmjqgjhGBeNVdrpqLw9MALu/Wpevomt+Sz0i5fkjijVQD76RJYip;20:T9FRrC9SGKVAJJrsAZLKZ3TWUBSZMYWfw0uGU4rDYrf6/KmF4YOb8JJIrcA3upkn48N+8nTf93pKPJaZ+rbGMA5g1t5scgbcAPj7GDfL+z0gzARaZydX/GHnALgCjtNH+8oIibf5INJR014Bb3v+ya2lZjZDMJcgRAKIfA5Haz+PC6izvF2MeizJtQ2vn/K503rn7gmlqQXoWqQobsffapSZkfrWLNSG+gTm9O55m4EAsgDiwvyZT4934/tNocqg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2018 06:45:24.0143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea717f6-79ce-4e5c-a634-08d599f7a534
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0134
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux currently provides function detect_extended_topology()
for parsing CPUID Fn0xB and derive CPU topology information.
Therefore, also call this function in AMD code path.

Please note that this series depend on the previously submitted
series:
  [PATCH 0/4] x86/CPU: Update AMD Last-Level-Cache Information 
  (https://lkml.org/lkml/2018/3/26/24)

Changes from v1 (https://lkml.org/lkml/2018/3/26/63)
  * 2/2 Fix and simplify the logic in amd_get_topology()

Thanks,
Suravee

Suravee Suthikulpanit (2):
  x86/CPU: Modify detect_extended_topology() to return result
  x86/CPU/AMD: Derive CPU topology from CPUID Fn0xB when available

 arch/x86/include/asm/processor.h |  2 +-
 arch/x86/kernel/cpu/amd.c        | 11 ++++++++++-
 arch/x86/kernel/cpu/topology.c   |  8 ++++----
 3 files changed, 15 insertions(+), 6 deletions(-)

-- 
2.7.4
