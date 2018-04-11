Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AIpwx48g0kLZq8JcGiRJGCP4emwBBYm38AeLFCKpBPNIaPfC21BAjmSbUmGVwk+SO79UjvC2+/Ht
ARC-Seal: i=1; a=rsa-sha256; t=1523456175; cv=none;
        d=google.com; s=arc-20160816;
        b=LhtAPiy6jgyIq7r9Y5+iyUu2eWnheacHHndoJBb39CcKRyYw0iBPBe3nsLuD1hSLbq
         W/W/hpMb0QyXii9pQY6ihmwRsYPIF3oln3/z+HLOpb7uHIxzf/zY8Wy3Tps6zHd2k+gS
         qGJJzwTAgDN7jcRAE5qU0Cq+sCFuN+UiVgfp3CdZJ9wP8oY5e1ZYuXKmQzZRLnAx/mv7
         UJYXFZ/v6MlrKipAJIQMvQDL3t25ib/vA0gn4nUca7cMun2DDLTxPSjKky7hoBHXykT2
         M4F8sATnG15ORRBUuJvXaqWMG6ZeCEF52Weomt0feukGk5NDJ52T/dmAILlEGaYuY4xS
         741w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=GbMC4Que/dUaRlBuE3CucY0t3VlZyQQZV3RMoBVTbQw=;
        b=qk9pwfyj8BtHoHGaZrSrvaGbWOIPJawVV+oA4vKYKe99jveTcuR+vjvAhkXgRx/Tqa
         BEc4WXphbjBbhXc+jITEdyefoII39SF22x3o8mrkVYqcoxeb2XO3PT9xwpKYwvTWw4Ka
         1iCPY9WGXcEyYfsofSDur6RPDaucX17TstMM7h4w0RuRMmreUKpj5SyTi57iGFgZ/ggW
         hLET33d/mBd+H5YbrHAm72nQfdiSGVvdViILsd1Uh/Yy8ZnODvlIx3VaeWivKPdM6wvD
         oqqx57GLOs9RlPI9Z2Lwjuqc9SWK6ML+opQ61QGpH6KXXABE4+sHsayseARLHuAhx+Dy
         vxjg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=OH63wR82;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.0.116 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=OH63wR82;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.0.116 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Andrew F . Davis" <afd@ti.com>,
	Fabio Estevam <festevam@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 0/2] iio: add unit converter
Date: Wed, 11 Apr 2018 16:15:53 +0200
Message-Id: <20180411141555.15044-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180410152802.30958-1-peda@axentia.se>
References: <20180410152802.30958-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR1001CA0017.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::27) To VI1PR0202MB2783.eurprd02.prod.outlook.com
 (2603:10a6:800:db::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2783;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;3:Zc5q0+yew2IrOI86CuNJH6/LbDQOC/K5zOjWaKmzsIuGNDRu0wCrIxg+TBOlWpwJ4Va/1V+HoXiOE2XRQZ4Lp5KdF2b3uYa5V4a6WEexlSdQOhlGV1nh5TvAGBbnMtHoWnifpo1g4oXDqd+6qzJpEQXeZ5psgvRC6kI1lXHOFJquXDvpQ8D5ywqCkcCrrEqhNqoq3v8Jg2on3P3EM7YLFQErAmMKRc+HYjoKQ6NOhik/VbD+nWqZJnLcCaUnS6ut;25:YEHliQJBiiPTyTtIRHRNOTNHCUMVR+KgllazlflEEQfwCT6nVjzuqzGz7lC8G4JUBGWAoUOHPkPaYS2LGEuQz61ZARh8H7wEwDNbrHsv1s/guMOD5yLmpcUtBMFES8EgeqDn85taMVQfTM/gBM8wc+DFT9tLRcZvzSu6RjlLCYGIVLedTkSEar6XeZXTljEkwCfbhY6oxtjS+hN9R4Rz5gBQFr1oVb+kKd9u1JxAfLaaCjkujFgg8nvpmhRi8iigos9meGmIS0PulYAzw9XiqPLIyxCT1OMZRjvLYXJDX4k2C0674cS30r3ALZMRR5kHwZVk8n44oCLCu+BAlCveWA==;31:nIVVTDrgpza/4Zh8tZFF1rh8DHlfSU+ma/M8HGrdcYGUec9Ro+ylnrHErV0rzxGacUmhTrfvVnTxK/u2oIJgrH1S2OIUnxDtWDV8rdOmUpv5TcmnDPGfkcVZEFErFZF6v2p2rq+4P89S8VCdRI2OHZekKMBE8YFhAYITTda6l1/N7ZWUuOyeboKASjUkQP6ftky0xIfcJwjt/SLKQIeWhQHy/fVN7zeuAS95esZQHkQ=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2783:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2783621F09A92339D5F80B19BCBD0@VI1PR0202MB2783.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123562045)(20161123560045)(20161123564045)(2016111802025)(20161123558120)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2783;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2783;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;4:KVXosGbs4C2XhW4XQBaxJdBwG6QDFECSH07HeuGEV9Ubkmou2ol3NiKRTA+45rOOrHTqcdKqVypFZ+Vc5eWmc+Z3aKmCHYsy26lngFXRO3wYyQec/fPOnFu9GjnTLoMI/k6qkdG/os6hfo8PIXr5kHA6zLFiZOb5D3PFqPyjPgyyifk6gXEcoQ+m99lyz2q6rrDjo7q6r8EPjNaMPyHb4biqRXKLav7HKCUCsJ8zt20BthHU50RtYmHbb5tJKw48DkRjsBvFLhkiYFEOuGWHlw==
X-Forefront-PRVS: 0639027A9E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39380400002)(376002)(39830400003)(366004)(189003)(199004)(8666007)(6916009)(52116002)(54906003)(6666003)(7736002)(16586007)(6512007)(81166006)(68736007)(81156014)(105586002)(1076002)(478600001)(39060400002)(66066001)(8676002)(47776003)(305945005)(59450400001)(86362001)(50226002)(486006)(53936002)(76176011)(316002)(446003)(51416003)(8936002)(26005)(7416002)(11346002)(2616005)(6116002)(186003)(3846002)(97736004)(16526019)(48376002)(25786009)(2351001)(956004)(476003)(4326008)(50466002)(2361001)(6506007)(36756003)(2906002)(106356001)(74482002)(386003)(6486002)(5660300001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2783;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2783;23:ohN2lUWFLDL+HtRBuGAa/TUsOSF/PiAUsi6MuFr?=
 =?us-ascii?Q?8QD2aew8P+/cmd8DqueRDsAgX/1D64SwH+oDl0oEv+yNphfeelC7NKxtTCiF?=
 =?us-ascii?Q?dK/nsPt7V/Jcd7yAaHrIYS7HJj560KlANSxTYkTu9chVmZ8tKtlpBeKaacmC?=
 =?us-ascii?Q?3A8fdSUf583w1EQep8HQoanJMJOq/K5qnRPPpyt3RV9kQqVYMIRTHZvKRqld?=
 =?us-ascii?Q?8zN5imjBZXPm+ogIyj5Uk5Qv41o2gyVHYn8OagayAV4RwjTicIBhdOhpiC9/?=
 =?us-ascii?Q?9CrC+UFlrzGQ1YVr+ewsytOJdwufH5+XqWr39qtOgSQRzbxF2iRZv0Okqk3/?=
 =?us-ascii?Q?XodXjfM0tOXep8NsNh8ZFbwirz7KzfUeSQnVHYlcsuhdzXmbMErYVxdMRjF+?=
 =?us-ascii?Q?BL8xIyxEKwkJ8lBJ8vFFfca4bLtSjnrtchES84IYLANXvgruu0pI+J73kEmO?=
 =?us-ascii?Q?Qlyui1rm88b6IzNIiH/SAXsAAZ1HuTzbL4iI0GTzeuTkiqquh9Uhq4lzcIBI?=
 =?us-ascii?Q?CxWkBzKJdxfWhgzfGjXLJUK6ftOBusf2cFZCSV+d4xJChLx9njhbKX5V2EQv?=
 =?us-ascii?Q?otnGrpyy0rUpZstZSp3pOUOZaw3eAJmMRPdm3N/mUEIKI1GE7hNesHwfSGGE?=
 =?us-ascii?Q?ZCQXpUgiFB4ljjND8gT8sMhkcGBmTx5GH9zOqb6ZeJuPrnzbXkRy1WQQ8MWh?=
 =?us-ascii?Q?47Itqxst1nOE52oRpAP1P6iDmMLwtHUVK/y5hMnoJ8yjPTv8OA/2BnLGn9yr?=
 =?us-ascii?Q?WTE71/htyDAK4apkMqIxOGZptZGK7nmowJdz7cuznzXHYx7z3r4hLteiH1L3?=
 =?us-ascii?Q?8nhavhSe7H3MFx0cD6OGXhrCndjMBWz8tSmAAT+s2n/IVsGG5a3wNA7MSZyq?=
 =?us-ascii?Q?DzKRUOp2XN8BlGovFWHRpud0nQ4Vg0WDK/qVxH5kd19/THRbvzEQuLv/0WaM?=
 =?us-ascii?Q?u+7484vrN2VCs8DGGhJSCIpxEAWOfocGSWuCGWYu6BfgKx3eNucPjtrRFf/z?=
 =?us-ascii?Q?Ax8qxovWgM1Z8QKWr9LH2GES3pJRmElGtpoqZwHXPBuRKI2AlR0EhQCJ3ZUG?=
 =?us-ascii?Q?rxvIpOgFwMCrbPn+tiXDkKr8SZKUpw6Bo9z+r301AYD37fxnrJLjSfG5iW1Q?=
 =?us-ascii?Q?+FJVHDtzuMiWYDSqqpKTYixke9ls3I7WbAjwb3A8C+OscEExQMQSW4OaHgPV?=
 =?us-ascii?Q?jd/p6YgycfxUlEE7J7UNyrjXglaNOk4h/F8fvBlgOIlun5HoFdP/VPAPzrzY?=
 =?us-ascii?Q?11M2PbERkj6mOhu54FqDpL6LoWtmHES9fDT8+8SvDO9hGqfQejHAACWVbACr?=
 =?us-ascii?Q?zgcq81xxm6LjzvjuMbZGq0++YRoBv4fJo6UQWsEuhvcVO6sU2cYNESOQ0pAX?=
 =?us-ascii?Q?Wk5ogOn/aMB7LzzBjZkLWzP52koSy01COFNuDVsRJqMSY4Eb3?=
X-Microsoft-Antispam-Message-Info: 8Jo2IlGluxEIHvcL76vBtj4xBKw+AXO3K1uNN7BhFbnXTcPI7k62+sy2R1I2Zbb/M5dTUMbtzDClz2wRzIkiS8yLeqEJQjm+4UiEwVqlTCZ1WsfCh6n9X72zk/avMIssbGcPWBbXY6sUgj0Dwdnvopoqkc5e1EH4sGFPRFkpK5b3q9y+9o/+clbUy8zzt+Zb
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;6:04+i635MxOiuHwdM8wNsLL62lYwQc0oRk6fR0qVHRx7WJ2Qigqmb8R+HtcmPpkapoWi1UN/wkGyo4GA5aGrb9POQlrkps85BMs//rceK/sCTY5rhJkTvyDyQoX/xrWPwbch/Ac1ILuWD8PdYiHiQ+wUY18rKWvMMYgKqk4VjlO8dz6koQ26+qYkkyYd743uZr2sgRhFBEwwKjUjeh/0QTJvdS4XM+LMsMw+WwulAIpgAs1jwEOuvdPcFd/iSp27hcQurX5rOVRsJxgKvBBzxqLJMROqQxYpPq4Ozgcw/8QvkTKUmc3FXxSANuIE4UCtUO4vtFJwQciaISP1uGOlgoSUG4tLqNl/5FNVpD8iqCHx4969g6/T2YP1I2xYK3zDuNqlkBtY5CTfKFlxomU5SUdkHwS9+jICkg7RgsO7jmT5RdfhHK9PeKckmf6gL/5tJETHfu8P0W08z9i+d1pwspQ==;5:Xw+2ncmvL7YE0IlkcL8JJaU1vUzbZ4+gZr9RjQ1oosAFZAQhy4+F6JEFisPlqJqHvEFPxyoa4kRzWf3CmIAIBPeP7hsdxty9oDf2FUffux1REeQsiJzk+ZqumM1U/nUr4A7/vK5fWAh8G8/IuroprNoXMZZW1Bisz89cGLvWt2g=;24:0LG0MUjQ444/TkU44Mpi2Lomn4ZmzN5CwPHJNbbu4kuIVDASP8lwu+8a2yisDFSoXN9DsqFC9VFRoHOCBNaomeCZSsJxSSMSK3r9G3bf3pU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;7:WpKl+QcnnowJPfzWtJ2/tlwRMofSVc7PG/PhMOKnmH8lSEvysB8JAkgULIYTmL3y+z5ocaMpUCdRNtymAn5m3EPGisj/HPIVi9RUyV0ozuKHDo8pugu/X4POwENuhsgpW29Rbthap1xZIs0vQeuXfghwrTyqLiae3a8feHedn9k3UPqwVKP69eTFnE6aBpCpr02ArGTf4owHpubBS5APvSCXBJCfeaRfq1gsVq/rLPvVZYNAt3gYEcFApjKRLkVi
X-MS-Office365-Filtering-Correlation-Id: c0cfd04e-2f53-4c28-269e-08d59fb6c62c
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 14:16:08.7939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0cfd04e-2f53-4c28-269e-08d59fb6c62c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2783
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597373525263580007?=
X-GMAIL-MSGID: =?utf-8?q?1597459582793477807?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi!

I'm now following up with one more binding for the unit-converter.
This time with a real IC, namely LT6106 from Analog Devices. It's
a current sense amplifier. I was a but unsure if I should have
the Rin and Rout resistors in the binding or if I instead should
have used the "gain". In the end I went with the resistors since
while the normal case is an integer gain, that may not always be
the case. And when it's not, that could get tricky. But I'm open
for arguments on that.

Cheers,
Peter

Peter Rosin (2):
  dt-bindings: iio: afe: add binding for adi,lt6106
  iio: afe: unit-converter: add support for adi,lt6106

 .../devicetree/bindings/iio/afe/adi,lt6106.txt     | 50 ++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 drivers/iio/afe/Kconfig                            |  3 +-
 drivers/iio/afe/iio-unit-converter.c               | 54 ++++++++++++++++++++++
 4 files changed, 107 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/adi,lt6106.txt

-- 
2.11.0
