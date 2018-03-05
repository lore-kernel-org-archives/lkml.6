Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932871AbeCEFcw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 00:32:52 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:24408 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932662AbeCEFcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 00:32:46 -0500
X-IronPort-AV: E=Sophos;i="5.47,425,1515423600";
   d="scan'208";a="274206553"
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=<>; 
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 0/3] phy: rcar-gen3-usb[23]: Add support for r8a77965
Date: Mon,  5 Mar 2018 14:32:42 +0900
Message-Id: <1520227965-4471-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [211.11.155.138]
X-ClientProxiedBy: OSBPR01CA0013.jpnprd01.prod.outlook.com (52.134.224.25) To
 TY1PR06MB0992.apcprd06.prod.outlook.com (10.164.99.26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 18996f71-d22a-498c-1512-08d5825a837b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(8559017)(2017052603307)(7153060)(7193020);SRVR:TY1PR06MB0992;
X-Microsoft-Exchange-Diagnostics: 1;TY1PR06MB0992;3:mQkKyy8f5jctheLAi2SxHmbonXunrPezGpXCMdBp69YkDYo2GGm0CF+NYQeqzHfzNkbvRIR40VMT08SrcEC7CG0RoxM5XBZR0HweKcBxZ+V28pE5d6Ztkgct1ObrruzKctZaWnQKI0iI5gotAkT0g7VTKD7yTLEfQQ01VVua/je3tQ92uDE1a770XzigvyQCN426I1QSq8dQa6+PsZYTe5FkvLLU44dnAbOmZsiZGG8skqvBB25sQIBvlLLCTZjE;25:QQGzKyVNMwBp3ms87eO5hXCujo3jyxbrY30E8wD5PZy1OJUBDNL6JC34tx5ilTsuIY+OWRbxShgE7KDXbM/+ue1r4VveMJLougk95PTP3HhUo7p2bgbaR1SXah/0OaTnNjN9o9199aqVSBVM37nPV5ktnoYlJI6Ow0ExKdQoXbjE8xrNrmv2yUuafeJwBrCKtP/4owLS87nocy48kzXGTL0cljS4LSDrqdUeAo9nhBPY4MKSzrXLaWn7cevEh0DPFBZOVSBdtM/6JdLntKgUVs16MxDehR5pGoLRmQ0Tujtb0ZIWgrvdSpBy5+6bxB9s6qBPtdXIiDejePT/l8ImYg==;31:ZQMituXhjM9yZKpCEhggOan2sTN+E/3lhE3JM+LdOJCiM7TtdoOmYV6vYOFXAHHABnqm4vmQxoIOvEOk5s+DtisS+sI+lq/ZBknywp+zVCNmLARqrAnHA3Vu5ESgoq8geUjmysntmWPUqQOKzWSBFr5LMQeNm9eDobr5MMKH6Ib07q23wTtjIeP1q9Gy5PoK+M/yIjfavBXpn5F9P5Fo4LR7JU88alpJM7LRW9ouBus=
X-MS-TrafficTypeDiagnostic: TY1PR06MB0992:
X-Microsoft-Exchange-Diagnostics: 1;TY1PR06MB0992;20:v51HAIfA2vCi131vG49liloiPmS3Fa3tfJjqbnMiKX6YyJVSv9WjDInx6G5foFS9ofg9g8IZI3ioWMUPYLo31vOKquS4ojJg9lO6qi2kStLzeSCyrTUnODBLrH6bd5+IkEKR7MAXFd4dCIxoAYut/1QWjNa2FcPHkz9KIdjekG+CJRfhwhaKCUcwUe29j0n3oAtS9j4ZznFA25Q3UVpKGdie+JwqY8D1RmdUrd4zEGbR79xsvvBjxKulnMJB1B/0fZxPJlHTZvA1+egT8MeMag6WCAEc0AmK2K5HToUjmULHw9PYg1tarEit1ATTJ5w5V7SF/NQFk6zqJA9SBNrYh+IaPvnP4uSeMPQB0MOakg+uW7YrWVmCsSfTtovQEeLG5QbN/Az15EoRXnp8USV7B6e+ACP0D+/KyljbHlMUV5t0JJBl7onJmG+b61wC27RvZ7n2nnCRiGGsy7giKZ6Zy+LFI4f1aVozBbYMRw1uz0C30QdGm/AQADrlFeCmQaa5;4:lKdTN7EzjLKL3Gg6fX9Pn4CVHcz+trPQsqqKEJS5uPY0uK/3vvjLIsAyPr+riJXmtADyoPV0EcEKobFNLZgtjNNFYrMB/OvbhIQv0E8wrH5TPk5ggC/+52mtJaP+5xbRl9Bz7iEEROUfD8qbTjdxD0/RtrVn0jkvgZ0LNOrn3z+oFSrNzpARRKAOObr7i1/YFvU99ru67QzUvzZ4YnLGeS/3Iupk3wlPuinwhfRgpMRItn55c8dxOJHjoNpe4tqqIXDLR0iL1lux4R8dsYCrTg==
X-Microsoft-Antispam-PRVS: <TY1PR06MB09924FB28E6D97A5A641AD10B8DA0@TY1PR06MB0992.apcprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(3002001)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:TY1PR06MB0992;BCL:0;PCL:0;RULEID:;SRVR:TY1PR06MB0992;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(376002)(39380400002)(396003)(39860400002)(366004)(189003)(199004)(8936002)(50226002)(66066001)(68736007)(7736002)(48376002)(16526019)(6116002)(78352004)(498600001)(26005)(305945005)(107886003)(36756003)(6486002)(3846002)(42882007)(25786009)(4326008)(53936002)(97736004)(5660300001)(6506007)(81156014)(81166006)(16586007)(386003)(47776003)(316002)(2906002)(8676002)(105586002)(50466002)(106356001)(51416003)(52116002)(6512007)(3720700003);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR06MB0992;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:0;A:0;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;TY1PR06MB0992;23:PpkwWvCYYIdD2N/7Y2/30fzh9EUth4b/4gxzMIQwk?=
 =?us-ascii?Q?NqqJpOVap49GNvJups0HuvEdH9S/776Z/7YNTX4nke53sUhqnokgvTCZpWvh?=
 =?us-ascii?Q?qOo678o0wp2bEh+m0vNEE0cFe69/ArytLDCmzS9d3SJWmEGKZLn1MPZLuXsq?=
 =?us-ascii?Q?1y72i2XtHVEUoDkz7ELIJ/iNFCi7cdUmiOvEQWYkAdM1tPqTGmgC0iCLTwUK?=
 =?us-ascii?Q?Cw6JlqN6ARBAFJhMjTbA3NeGJlBYkU5yXqXQb8GjIUKqN4LitQC/qWs9Hzln?=
 =?us-ascii?Q?NJEii/mHnsG0kU5RCHBW47/5REs702UyeeDm3oKtE/mtMPyi76g3EqzLMeeW?=
 =?us-ascii?Q?poixg/v1AwRw7JTSRIXHRSy9JTrm/SJJaqyWW7ySaZHUiS0SaUsoOMLsHt+o?=
 =?us-ascii?Q?M6xEfQUFYlvl8m1Y4iirjf2b36cM1MPmRlL3EkxDHsxNDYa6dWGRFZe2a9TO?=
 =?us-ascii?Q?6li20qHedT+TsnvQ8hUclsPVcoSTBgAGytxXLRKYfatUhbEJi29yuahHDvQh?=
 =?us-ascii?Q?xnUxgBPuysu/FHXAjDVtK3XUPadOnq76KUGiy5mJc8nhHAsRtrgHlhWVmiL9?=
 =?us-ascii?Q?1VCSCi/0p6+oGcCrP6QvwZpwS66A5WJ0TPjoRWkUwcR8H5tZqwoanK3Xos72?=
 =?us-ascii?Q?tdqIYLyQ2fL5WOhd/qFSadDnoamR5HFhAuOFSXy0wLm+oGcSkm4TiEkrH6HT?=
 =?us-ascii?Q?LsGIKA1IgpKHMN/AFS6/dWDcaCT0SxwCn6eXMi/kBU3kTyIOpd87sEY12fpu?=
 =?us-ascii?Q?oedTE3UE3RhJu7eZWiVr66M8yzQLKr1tEssf2QEZlNJKgGdx7ttJ9glpCu/8?=
 =?us-ascii?Q?QEa5HOwfcjUQfZZ+8rcnHrkP0mQoS4+EB79dyjTOPMpgZutFUOJtn+VeYsmO?=
 =?us-ascii?Q?LA/3Tbx8zK+PxTikh38whYSfbx/OsALOkKsnl3GBzKX2bvspgYp7ujNvOCZV?=
 =?us-ascii?Q?qiTVsi6gkRfvOrvRWkZerbSGxAEzVzYqdQhGFyBxpKd+vHwp+Cybfe46SItm?=
 =?us-ascii?Q?no6A6jbfQM6VqyhyT+eWBjECv6jOOiyWexsK10cML7qP0b34j3Xs4qJ8UiHP?=
 =?us-ascii?Q?ubnsJZgMO4+fqV6/6HMkIE+Uom1?=
X-Microsoft-Antispam-Message-Info: 32hSxFw9uVGR0ZaQWo/jNLSUPQ8b/SgYEtC5t3qgqgx8PLamPrHc1dR25w3FYI7yUb5J9Av4bQ6nGPdKy5JylqtlUfopn5TpzE+4qVJINJWwxdPIoV3r1nX1EkOiKxqePL0GG+ZMaglVTp3LBC0kkb3w0fuY3EXTgNTZ9IsfS84J06hfz8ii3cmPD+UyfSIV
X-Microsoft-Exchange-Diagnostics: 1;TY1PR06MB0992;6:vfFoObFHglKW2j3GpqBvFn6QFewWLwORUFtNkYZDLxlZK+FmQVdx3tiBi22vYwi58uc72USMXDFJpknQQXTzx3CVNvRtaqQ8UXIq7VlKRd7j5mE95HHmcflDe+i1/Hoisf7HPqjZFmkxnBU3Th8lUjt0byM3VGLbbGjD41rS5OdAq8dt8zzNVZ3N0tlZwju1rWnGboNm0pJqWxSGTwE8XrQlEp1A6GFNNpXlb3NV/71DmaABHmN8rizRSzESuzZc13xjyOwArghrgE+eUp9BVAaeUdABw9hQKSoifLhqYOc9wcL6o53/YJaOUx5jD/CsXb+uW2Zq+5tD57nPBiRr/Ibsw9ZkhMTDMTbPBTZiai0=;5:EC0JhckHm5CPT8tlhdJmo4RwR+75xlPc4Uy7n10R4X6Kah521dv7INUz6W4loFO94dVk1dGDBOYRdTAEhbHVi85cwcYxtDdAUgu34vgFt/xoa+X3I5/8DzyPH0Fm+TdiHMD5hY5ANQIb/ra/SjMbGp3fdyUHcKMP9NMwxWtpWVw=;24:aBsSfKQYxy+QXVMR0HYDwQTcDbavrzy4YkQUPbOlkUAArul0pMKJ836d/mUqVDOFV+Mi7TlOvklLpCNf7WvPkpz/XxpIFVKjKtJSaxbomqM=;7:xaDxjtLIrws0ZnPSZoIqbR3hpNRUKOBwrhHlsEq9wFJKS/0nDWd5V/hvI7LhtzIA1ZWTbj0XeQPlug+hjnCZcwNZ/NwlvPW06S3ke3ayOSyipKH/0BqNkz/5aJzT3UqwzR3gJ+AUTnuxzRNPtf4SKI35ej+l6YKGCtNuLJkipQZKUomw34jAc+P5boAD2wdOw+4O5wS4CSrUaewY6DJS2rHkMv0csiWYhfDb/GRrjy8FgYv+Z6g+3AGgYKabKgiP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;TY1PR06MB0992;20:2E/ciZka02DNvziSTEffTWHI0t+fKjOC2lg2bX20WBssH8HHvcv5Swz7NSKBD8SSB/5jEjblrHyDVk5mPm3OJgVr5VomJJX4xnYWXOvvzVGoi1cTYejdlEw+P13eXk6FP5xQ7/XNXZojmVvqCVav/3fl7UCITwDzbFMs0BCeCIg=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 05:32:40.5154 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18996f71-d22a-498c-1512-08d5825a837b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR06MB0992
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds R-Car Gen3 USB 2.0 and 3.0 support for R8A77965.

Changes from v1:
 - Separate patch1 to dt-bindings and adding of_device_id table entry.
 - Revise the subject for dt-bindings patch(es).

Yoshihiro Shimoda (3):
  dt-bindings: rcar-gen3-phy-usb2: Add bindings for r8a77965
  phy: rcar-gen3-usb2: Add support for r8a77965
  dt-bindings: rcar-gen3-phy-usb3: Add bindings for r8a77965

 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt | 2 ++
 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt | 2 ++
 drivers/phy/renesas/phy-rcar-gen3-usb2.c                     | 4 ++++
 3 files changed, 8 insertions(+)

-- 
1.9.1
