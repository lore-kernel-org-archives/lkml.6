Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-195729-1522174459-2-3285230917630412607
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522174458; b=r/OJF4hROAawEEq+wtYtgruY+QsEJl36l/MvYrAI+tfCfgq
    A4AEIm/gDskwnoAihEYEKxZi8z6ooCoGF1HMYAQMuTLjt6BsasYH3vZWu+67T0O2
    9rZOHmjtYJswmomeNXL4bWDPhvWtdaZuEpfkqPpG4deSvxXzheGZgsg3h1r0HE0v
    DYl2HEig8ranVYKazTgWIegHZKyYS6+JqlivCX3QFVp8LrwKYuulduvkgMGSWt/7
    0s0bXJQ1IKuymV/G8cztf31DfFOKIEGPYRjdf88eiWhSZQdb/F+XjdKEmGgXDKEb
    CNTYDAXC/oJdIlNVaEx5i1iUmFFJVUojJVhKfeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:reply-to:cc
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1522174458; bh=iMBg3KfAOXAavlxkmHddD0VLxqnJ6EEWJTG7XtpJnNs=; b=h
    SpRQKgtaVpejQhUw+FMOmRY+emAQzw4mMv7ezw11mlELIvhupnKPh6bjO4xDLGal
    uUliK62qfRK1/OZbp5fa7AYjH3AZ5KgBS7t0IpEjuiVObJcZ24NIbTKc8gWyAxGV
    Qly8txcYeYc56rJGQdLcueIfKY0eD5F2/xNeIISNTpMHS+ze51HXVP7HbvySA/+Z
    xnyWtM6zcEbc8N0m8cIHj8mOI6cka0xohMD0fMzTkUf+sZBIxpMbLZNXIYa3206H
    2/UFdX50Oei6Kmpc/pjmC6fPsPR/xA58B/za4c/DgLF0MR5YVGUMl0mAQBmf6/7G
    pmHTv/gkL7f26qHpe5H4Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=ClPMnGem x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=ClPMnGem x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHtVcqSWS8QiTE1z2ffMbkuvNsLcv1ot2Qm1IlPe5qdQ7xR4r25sQ305IN0GEsxk9jjyXc2O/tEpvyIGZpZas48KKBR1t+5opONUsMkZ4fMTLF4/1p/a
    vKfrdowvD2iVbV8te4VNsxK2jlAH/XTnIZc4a/VglQfn1nBmVWj91GnVx296doZbWUshYpwK3ctDV88rzQk9cMR+47ukfu8Oe0U08OyrBzYDdh7Xb14UnveG
    c0MPE4gYecE1zE8G0T8nwQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=TRjyw0CnJloA:10 a=P4uAHAV8DOQA:10 a=JMP4OFuIcRoA:10 a=SJl39FfINJoA:10
    a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10 a=dw2S5ISiLjYA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=8AirrxEcAAAA:8 a=DDOyTI_5AAAA:8 a=A8MY4X8aQWKJThehOIQA:9
    a=KMfNuoIj5AD7m2FG:21 a=UUlsGZcvWQg50K42:21 a=CjuIK1q_8ugA:10
    a=ST-jHhOKWsTCqRlWije3:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com;
From: Roy Pledge <roy.pledge@nxp.com>
To: devel@driverdev.osuosl.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/4] drivers/staging/fsl-mc: Use devm_memremap/devm_ioremap
 for DPIO
Date: Tue, 27 Mar 2018 14:13:31 -0400
Message-Id: <1522174414-30380-2-git-send-email-roy.pledge@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522174414-30380-1-git-send-email-roy.pledge@nxp.com>
References: <1522174414-30380-1-git-send-email-roy.pledge@nxp.com>
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: CY4PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:903:98::33) To HE1PR04MB3001.eurprd04.prod.outlook.com
 (2603:10a6:7:1f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 652b1e1d-f086-4cb3-ca43-08d5940e87fb
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR04MB3001;
X-Microsoft-Exchange-Diagnostics: 1; HE1PR04MB3001;
 3:Kj8v4VGhyMnSypKw/LD75R4kAiP8eNR4kxbqnKDHmp37ugWALzcpXo3HYkorEJ/HMLvVVb+wopl5AkOQZMQKo7GGBMDGbsQzsWv3gjTdEJlkXVnfi1UnckSvr5j+aNGrybtzgpwQG9k+3zoMuVdtjd0AExIQwj8xolObfTn7cYTMDaJIyjQp+DTAK6KwzUdO9gyoT1WFwyqBT8c4tEOEDO84UZLIT8q2sdyePQq5O4er2zWQb1Z60gu+wLGGJSRB;
 25:EC0kXUE4Zr78c/oxjagpZORyP6vTs3TLEcku/UA/wYJVSOPWFbzCcf68HRFxDo9MFYzyWXZBlNivlBPKUh++F3jdWZYBUDQi4JrniF6DjIgd3XuZLQcoguJZO4ieH2jUt5hogTdbzylLypomQiSv81P+ZCJ5U+qAdIy87IMlJSQqCv6cdVa2xlJgSIo22sy3wRK1jhBcvoJ/7sbYyFWDaVydsPxIkx1miv0hlWy53NY4Ubj/eyif2G0wOVAHnGZhwBLGcW3PAwFZamD+6BL/Yt5DqbecnN5oapGvqnx4OxxNgxJ31FxLIgLHDNa7hFf71za6XrDfWKC/F3q254kkHQ==;
 31:08rj8Q/m2eneeHvBP87GwwjXE87qTJJ1Op/o1jEpXnniBrOSnnThyoai+KHbBP1xDqUOGrDJGEhTcdsM+UFLi88emTRXKq7+0zz6p5je7CHmN8Y27n/NjRbCVUlrDOX3TGraOaDjEmsv5D+NVLPJ4Tg5ehC9QSPRIplV+4S++/njczhCCAuNg7KSYux8/j+Tf+DZEzmfS3cQ8EyjpzcjVlxV1ra3vBOtwLc5tgHGUhI=
X-MS-TrafficTypeDiagnostic: HE1PR04MB3001:
X-Microsoft-Exchange-Diagnostics: 1; HE1PR04MB3001;
 20:/WFXo8vDPcP2HI7J5a+D7sQSXSZthzrInZl1mRsE7N+181cvzuWhVSKW1y1yHSdi8Ld1YoD/6XFFDAR1G7kEGLjXba7Gdcdz2vkbaOmP1q6meaB1L0uCoNBUIxCsZAWDCnAuqqnMSy43WoJ3eRX2U9+I+AsWlNsL2sQp4QVgBg41IufbZXYAP0fBlLGInwE1a4Jcyulv2+Bf0JUarVP44OHADWsP9yJ2ICxhl3CES5ez3I6hIi4VLWGnt1a16vaiqgFVARQTpva5cKaHAjcBif9KhEr5aPUgKXbkjbcKDMSAxdv1dqTvOFHDfYLv7MCiuHYLpdtO0XOFscHS1WFYI0wgAlDG4WQrrpaH5efT1bnphhVmgwiLIV5NSp7KXb/Mr7fcn25Y4wDiqK2wNGZNPIrlmObqOhHqP8alS3EBJoS002Wl2NnLbOX3IZ0Tdf0A3ha8MBJorw6osdaek5CFvSxoETVlgYrIEFlpZJZFIVuz+todnc6ePh1KDXfR5Hij;
 4:fJi7m0YWw4tSUx3ElivLrnFbhN17se569rO23n41Rb1QXf7og1bkGs8hJyDx7r4OVKuWPctSUcOMtlapG0reWoYIK0oiWtFOTZmzQpJ6QLrKm1x3drHmzVCVWgAsxk5ccgu9MyS9LMBKn/xPAfCJZzGRWXSkYFChHQOYgo6HHhqyST34lkYEgJfQcBMY8bpXPNNeU8jiheGCD/8oXkOm0YmjSdXkwFhZ3lM6DnFIrz8306y+MFhZbV+PyTk0azaSPYrm1uZY4ez/J8XMYustblPujJuEbQw0gWlIBHhICOnas8iZ1sxVmrAnm4g/w31udAX7tPNxFvMdfVqWAeLKZzUJ6PN+DboFnnYk+drWEX4=
X-Microsoft-Antispam-PRVS: <HE1PR04MB30012BB976C9442AB9B17A5486AC0@HE1PR04MB3001.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(275809806118684);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);
 SRVR:HE1PR04MB3001; BCL:0; PCL:0; RULEID:; SRVR:HE1PR04MB3001;
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(979002)(346002)(366004)(39380400002)(376002)(39860400002)(396003)(199004)(189003)(16586007)(16526019)(47776003)(8936002)(43066004)(106356001)(316002)(66066001)(36756003)(53936002)(50226002)(305945005)(2906002)(50466002)(5660300001)(86362001)(4326008)(3450700001)(81156014)(6512007)(81166006)(446003)(48376002)(7736002)(956004)(2616005)(6486002)(11346002)(6666003)(76176011)(8676002)(25786009)(105586002)(486005)(97736004)(51416003)(3846002)(478600001)(186003)(6116002)(486005)(26005)(68736007)(39060400002)(386003)(6506007)(476003)(52116002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR04MB3001; H:otc-sw1.am.freescale.net; FPR:;
 SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; HE1PR04MB3001;
 23:ck+//BRWBxT+z/5P1+buU2big1p/87xUdR4OKWsx/?=
 =?us-ascii?Q?GbNhmC+/D1sq4OMBTyRuBqWNB4ci6hx+d0Y38A8alPp5c/5JxoWFMyN5iWP0?=
 =?us-ascii?Q?ctBSADy/n17VJFTE3xubyKiVeuZ4x/av5qdD0TNmGMTOIzFpfzkeqZSkdAwJ?=
 =?us-ascii?Q?LEdQE5e99SkRvR4bOYwoYQMDvWvd6tuJSPuJLdfjnOaN4jQnscpya9m9cwK7?=
 =?us-ascii?Q?Y9KZwM1ki8Sko9mzybXQ8NQoKTveHQS7M/HQf2Q+1XXPLaJnYGcOiJtUJFce?=
 =?us-ascii?Q?EidPMyVaFTBgz0SLvgIprArVUkDEcqeeVWm6OU6XbfFYS+55Gzm2BlZkSKnL?=
 =?us-ascii?Q?TxP6KdndZvg0NLn6Fw9xIwKuDI49ZMI1tp6ynARJMZGnn7j0AkrAe5GnhXOr?=
 =?us-ascii?Q?epCL3Ib/17OMCGp8vPULkg/3vZiKZHQ1ESlKGMXMuEXRRFvKTJdH1L0B4Fxu?=
 =?us-ascii?Q?h2emh9fJqEoJAbSHVdJz20whpKh2Yr/A01imyxo2eIlfXn9uTzas6a3O95RN?=
 =?us-ascii?Q?/7UQTK95zQ9Q7sNTshmO5SR2MGms+OaG2dVmP3KUWgS93PzgmBJ5OwQSi7Li?=
 =?us-ascii?Q?/CZ1XLUOd+nVVPetpBUwGsXzs2PWPNU3JP6PmE5Megz1MnoBtBo+1LghGj4X?=
 =?us-ascii?Q?3tifNDZplVa5Ru6mQB738BaSqVHjZnbbR5rwbh1udOCumHF56h/NHG23YNZk?=
 =?us-ascii?Q?d6kSV/JExxiywdrt4oVZxVrN4TgS6ahsnRR5/S2bECL3yvum1tGCw6r+hnp9?=
 =?us-ascii?Q?rGcEbfJA++WitYD+YH7BcSZE8q+n9r+b0uNFUZPUgUflLm+M4kAbg2yNylLl?=
 =?us-ascii?Q?YZyl81UqEamdOKPLbn0L/Qji5KXk5ZoU9X5UF5+C3Pnj5YtqY275UHNnhSPv?=
 =?us-ascii?Q?ZeXRKuKgmE9naZKmPF9DorZq8j4mnSgYT1qC6SEv/5Tf4oUVMPF9fQPXqA7G?=
 =?us-ascii?Q?HWJdT3wavN4qx/YfwrrJ9R9T4pVi8vMix9i1OUpLraulAmyt6NtkuFDsAFLR?=
 =?us-ascii?Q?sm7iVe4lxSbp9tMg0Ep8RYobTYlomw0tdw6RTIdVXRQF+bZ8MFOtxc7Q5tSX?=
 =?us-ascii?Q?ltatVkBdKdLVweVeYhejoPvosAftg87uHIp3vhM7u9BfNkIdHQWQjHi3xnIG?=
 =?us-ascii?Q?i2yTDir+zlL9r28OIsp5tpo9XwLMSWcIQ9oKyX9MFj4fqk6Iw2eRiugp03EX?=
 =?us-ascii?Q?GEvEPdliF9IDDgZNoS18WKlOCeMiJvFwwLrlUffU6s3AoEGFaFM7j/HDeNCv?=
 =?us-ascii?Q?WOYnnFs35Cs15DZeRw1bDEEW8wfEZ/619y3pJ05PqSRQYCtiFdzFHHf5xazZ?=
 =?us-ascii?Q?DaaUAdtwnCxkSWgnXL98zjlKg2kKWHDq7nNqFXg//BA?=
X-Microsoft-Antispam-Message-Info: ShYFgVEFZLRLxanOF0GYjDCkcvWCt2lQRsLoZonYKrFdWZl8Z4v/FfgmOYrtGeJZHVBDVaGjwaFSkS4rxStpXQiM7boJP7bDuYDGhb30mBOEmtD2KGUB4BzfqhUinDVPBiURzlnakQ8QcabBZf2lGdHGAOGuDnHgZtVGPPj+pbCUyLWJQG9AqoxXg8z2yME7
X-Microsoft-Exchange-Diagnostics: 1; HE1PR04MB3001;
 6:0hj0OlO7E4jsR0wwr8v3ptBkUzs16aW1RPAevNztokkEhcKS5HewfM1ypNWVas3aon7LCBiOc1UgDP7N31NvaXi0Nsx5vE001mu3618GLS4IOG4onkl3RYrCAYvSLBmhsnLjmd6f9xnIYi4gQhuRMrthBJ6Iq0c9a3rVbAVEshAwbc8a+lV6GTcr7s6GN4HfBe1GTfKkyJAHFp1ML52YVUEP1WwsIjh46RFYPUdrYf5VTN02ZYAFzEi30mTJOBZSi7jOXRmEsEyNV+SRuAOF652r7/je4E4vT9nC0hhZdtVsbRcfL5fZq46IrzzMST3uOEqe0JXETuOiZc3gPj3jZ7UJUr7DVRNJwsm9fr5FlTxvIF+ZANu20TuTa2OwAf17a7i/1x/+QpaLERmwP1H2Mb76/C2aytyPbV4d/SU53JQqomolQ01Anpi4D8IgZBc9W7RmnM+w+mjRJ9yzFPzQpQ==;
 5:EEZoDfXoLAK/tl0fkC4Ij5HVdlflDMfA/b20Xd+xjN4i4219huRdorODdpyNFiMwMEagqk3ZXBCSvN9hhYM3qKs63lT162/ExtzZMyWjrD/0OETNk6wQ74luiKZ2XwVUgdq2DUb0nbpw8crZpCh9R6Xzm8qs8gdUuxQf7iBidMk=;
 24:SAuzwUARfnpj/hskGGnoJXC7tWpf9NybPjBlEL9rLzWBlHb1DdGg2rNSRB/EcKJFPdSy+KQsHTeg9ao8YGwzrugtgtSgkmxsoBqyPqONJBQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; HE1PR04MB3001;
 7:RPcUCwu4nAER9u4o+Ox/ADUqzE43iyDV1sLj6AP8wWKEEp6D9dwXsUTJnzns4KcObBnDN9g0OpX0HnVY2sDo9WzNUJ+FJVMdmtpuI77NZc91hqT44V5v8XxnFeAx7jsIIETye+V9PZrs6z3RpTVtE9m8E5nse9YOlKTNxonzxBTBhnDsjLLqq0kQGyucZDatXRNiNDqGw/zDxVy/SCsFR9/w8dgaFPgRAFM9Y9lnM55uFo5U2lED/B+6IcmFCgKs
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 18:14:03.6080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 652b1e1d-f086-4cb3-ca43-08d5940e87fb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3001
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Reply-To: roy.pledge@nxp.com
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, horia.geanta@nxp.com,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com, stuyoder@gmail.com,
 catalin.marinas@arm.com, robin.murphy@arm.com, Roy Pledge <roy.pledge@nxp.com>,
 laurentiu.tudor@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Change the mapping of the QBMan cache enabled area from using ioremap_wc()
to devm_memremap(). This allows the __iomem attribute to be removed from
the pointer (which makes sense as accesses treat this as cacheable memory
not IO memory).  These changes allow sparse checks to pass.

Also use devm_ioremap() for the cache inhibited area so unmap occurs
automatically when the device is released.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/staging/fsl-mc/bus/dpio/dpio-driver.c  | 19 +++++++++++++++----
 drivers/staging/fsl-mc/bus/dpio/qbman-portal.h |  4 ++--
 drivers/staging/fsl-mc/include/dpaa2-io.h      |  2 +-
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
index 182b384..ffcbd5a 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
@@ -13,6 +13,7 @@
 #include <linux/msi.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
+#include <linux/io.h>
 
 #include <linux/fsl/mc.h>
 #include "../../include/dpaa2-io.h"
@@ -146,10 +147,20 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
 	 * Set the CENA regs to be the cache inhibited area of the portal to
 	 * avoid coherency issues if a user migrates to another core.
 	 */
-	desc.regs_cena = ioremap_wc(dpio_dev->regions[1].start,
-		resource_size(&dpio_dev->regions[1]));
-	desc.regs_cinh = ioremap(dpio_dev->regions[1].start,
-		resource_size(&dpio_dev->regions[1]));
+	desc.regs_cena = devm_memremap(dev, dpio_dev->regions[1].start,
+				       resource_size(&dpio_dev->regions[1]),
+				       MEMREMAP_WC);
+	if (!desc.regs_cena) {
+		dev_err(dev, "devm_memremap failed\n");
+		goto err_allocate_irqs;
+	}
+
+	desc.regs_cinh = devm_ioremap(dev, dpio_dev->regions[1].start,
+				      resource_size(&dpio_dev->regions[1]));
+	if (!desc.regs_cinh) {
+		dev_err(dev, "devm_ioremap failed\n");
+		goto err_allocate_irqs;
+	}
 
 	err = fsl_mc_allocate_irqs(dpio_dev);
 	if (err) {
diff --git a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h b/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h
index 4488a44..69db3c8 100644
--- a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h
+++ b/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h
@@ -15,7 +15,7 @@ struct qbman_swp;
 /* qbman software portal descriptor structure */
 struct qbman_swp_desc {
 	void *cena_bar; /* Cache-enabled portal base address */
-	void *cinh_bar; /* Cache-inhibited portal base address */
+	void __iomem *cinh_bar; /* Cache-inhibited portal base address */
 	u32 qman_version;
 };
 
@@ -102,7 +102,7 @@ struct qbman_release_desc {
 /* portal data structure */
 struct qbman_swp {
 	const struct qbman_swp_desc *desc;
-	void __iomem *addr_cena;
+	void *addr_cena;
 	void __iomem *addr_cinh;
 
 	/* Management commands */
diff --git a/drivers/staging/fsl-mc/include/dpaa2-io.h b/drivers/staging/fsl-mc/include/dpaa2-io.h
index f71227d..ab51e40 100644
--- a/drivers/staging/fsl-mc/include/dpaa2-io.h
+++ b/drivers/staging/fsl-mc/include/dpaa2-io.h
@@ -52,7 +52,7 @@ struct dpaa2_io_desc {
 	int has_8prio;
 	int cpu;
 	void *regs_cena;
-	void *regs_cinh;
+	void __iomem *regs_cinh;
 	int dpio_id;
 	u32 qman_version;
 };
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
