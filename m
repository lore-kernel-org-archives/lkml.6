Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-195729-1522174472-2-13025179861159415501
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522174471; b=KDpexkLMpjyydDtzS+BLX5zUlIPCClyumixpjqDU1QkfTOH
    17sZmcgrPY455KyrMKf2RN6KZ2oRNotLqqjciMz2a2lWjkjL439vFzK2eqLTwvYw
    tQH/r31qxnYO+uIwf8tTECb5unPlKEtDak2f5D0icNE4x1ct7ErcRe8ccz0MtiSP
    zzA4+MDBEFnl1qr0RlZVu+we2Q2UqtrXJHfhw7vwiaMeHDzajFQtCnTdPP68A5Zw
    Gb7om1LRqTwb/IWpP8ephSqusBRQZuDI7Gw3oiqKnUE+6Bl/06ci1HZ4SFrGitzZ
    zpFwf35aIYRsZw6G0ItI2z/F2l5FTJVbmab3DBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:reply-to:cc
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1522174471; bh=G+Spvp74v78fpO7zvLhCdMc/QGsr4kvy50un/uX9jm0=; b=j
    d3Ff9dfqikmyxoa+V+BuzUHx9hTezQlzcL8VVjQxztfk5V8UWIm3v4ZxoIgDmA3f
    xDp1/l5FB5kAQUlOQVV4c16CQRXeQ/irGFtvo1+2xTRCfFxDQqDXEGlp9qy9RSDJ
    SsTVnQNRdHu3Rb8v1PnwcyLxlCFfQhJJTmtE1ggjf0D0hYxRqRXizPVeiC3hApZI
    0jMetOYRhOy7Pqind7uRuonkwArTzeimGUhpAD6uIyvY6H9wlbExzZMIRc40ZnJF
    GEqY9LuVx87PWvPeM1X4gHUvvt8/i49NNxdM2vFpxsb6K8ov9fbppr9KE3Q90tiv
    9lXcqBhaPhQyoUgHqmY4g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=Q7NEpAR3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=Q7NEpAR3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK5pIImMuabAuWoRImmxZbKZXXEMXHCNkacB4be81UsxjMPp0JeRknV9+pbCMpfPkTINFmYgeEj/twFfhTyzfGANLMZQToLT2XHOCI7nzrOtCIoBz62z
    QIHXW17cmVHx/IZHPlX+NMZ7L5eJg3ZHcfCyfrOpfga9iBUKjt5IbdYsS2JcozXLLkfOJLy0nmSQLJGkGY71uCCNsntftLR2a1RYVPbrOaxNSQwmjpcCKcRv
    q4qcZFoAGQQXLjlqiUBNqA==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=TRjyw0CnJloA:10 a=P4uAHAV8DOQA:10 a=JMP4OFuIcRoA:10 a=SJl39FfINJoA:10
    a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10 a=dw2S5ISiLjYA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=8AirrxEcAAAA:8 a=DDOyTI_5AAAA:8 a=U2NixeQyNuVAiBXHB4UA:9
    a=CjuIK1q_8ugA:10 a=ST-jHhOKWsTCqRlWije3:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com;
From: Roy Pledge <roy.pledge@nxp.com>
To: devel@driverdev.osuosl.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 4/4] drivers/staging: Remove fsl-mc driver from staging
Date: Tue, 27 Mar 2018 14:13:34 -0400
Message-Id: <1522174414-30380-5-git-send-email-roy.pledge@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f5abaf9a-0440-4ba6-ae95-08d5940e8fbd
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR04MB3001;
X-Microsoft-Exchange-Diagnostics: 1; HE1PR04MB3001;
 3:3siFXR9jIXwQRZxq8tIiZt0tbGLBpzcW7HBWRzouxvR/wZ/IMxvSBVwHDqSH6v6JOVfCUmzBUM2QA8jQEmtLQn1M5rd+0Q8WMbCNF8USSci00GS7gmWq13mvL9jfNBrqIAtRt1yFs2msJ37s6M3ysza43QhMO1TpNcfyGfRfNLzrTZVoQrQU9oJU0Q8dqOE1XSUkurI7xV3QEnlR7kc8BtWTA7SSuD5Mo15cQpd8rKvR5H60BKhfSl4vuEzqZoEq;
 25:cM3d0w1Q32DbObqLAxauKyojgDGa/vfMd6mynrNm9i28v0kswvmgKzkHlRAYk9Wp/wM9UyMnUGe83zV18eHcaq/KfEChUDavmXGrQQhbEXFjyAMdcWcH5aBF0NYXPrJ/vPk8xguclNaKp9mvQapTYAgJ6DIy99VgT6JaLpDM5Q4tMLRvkOi+MDtt1BHJq9s52/95EMr6d0g5DgcQhhRVwS1+34VXYyI+ngmBrcl2TCJJDoUr/uKr/9p+Os/1amUZMUVXOkMV+GhVctXhQKBSHlx19Nax/0lElHAXUEco1qTzxcI5sOr9JzF4/+dUT9pHRJa1z1zPvYG4/+dYeLmFQw==;
 31:lshwOxahqXfpl/KaO2gnF4PE9YE+axpXOhGz9P7BTPG9nAmA1X1WzStTqiWMtxfq4JA6zghJV/tN6AP7rl3fxMZoQyS4A+ccsJxiEl7Qgg7Bxti1f6iFRyblNfHTzPi10lHx87xUYYYLk208oEhsLCG+YDSJQYdryMaVY7ssB8SfW7CAtcYrrLgmwm7AKw3evSW5alS8vJS9A9BStIbH1qNMZTdaMwFKaCwhXGUyz2w=
X-MS-TrafficTypeDiagnostic: HE1PR04MB3001:
X-Microsoft-Exchange-Diagnostics: 1; HE1PR04MB3001;
 20:6wHYhmNxOz7/213QL2deXj3M1bznSgcTKkEog/UR5eeZ3+xU1e7XngMQNUegluA78bqMTgU/G1U0U7AGTYiHmxm3kITuDSFIjE+R266TT3Ouu1o8XwL9tEtP2QRst2d/CBL9QgEAm71YrOS71gpKR82mn4CaEn1NGYbCa/ZEEG+ZhMtkX1xMX+SuXQsvNSklMXUqvHyy8lcm8Nx1+w6ay+M3V7lG51Q17sKQiChvjB2yzzTm/MQQG3oz2uYgTaWKkOXm6JF9rbguu3ucMcR04Q+2TaV9rgqyJ7sObVJrXth2TxqYMbLqXtGif+CqeUB+UtU909m49FeqaBgS8hqNw2SfwwDDcJDsSs/C6NeKUn41FWc5O/XkkUOL1OnpulUtvlSD2qsTM9jxHQfnkQt+opidgoedBs0NPzckV2xQ9pL5mq0IJhUBPdsWWq3pSiEbon+qfXsxUUWzvzRPVDSV5BJyLZVJw4MK1zbRd6N8Muk6aMt3EC6cFFVUn0o4jEbg;
 4:xZsSzUUSuUttyEqRP/8ORe+eXtN2guJqFCunLuQcwg46O1KQ7QaFOs023Oj1F6ZFjWzcSkR566DdFqeVPRS/vfbG5/0G/Sntfk+dIBgASQTX+sFnqIiwbUyAWWvqoV4M9YTuYY+DXAsHSx5SmYiPewcAGdcsvX3oSnYh/ozUoiNlm2SmI66mQdyFkTGD1B+MlMlXHswUcW3l7WpG3HCRd4D+FTjrvrHDJDWc31piwrb7xeSDhQzSN19/YhrRUbawoo2GuCi/P3/hUO1bMN9TbB+CCZ3U9WmeYiMMltAzI5+zeDaEjF11lTr2BYyiqiSW
X-Microsoft-Antispam-PRVS: <HE1PR04MB30015F03193B681362D7D05E86AC0@HE1PR04MB3001.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);
 SRVR:HE1PR04MB3001; BCL:0; PCL:0; RULEID:; SRVR:HE1PR04MB3001;
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(39380400002)(376002)(39860400002)(396003)(199004)(189003)(16586007)(575784001)(16526019)(47776003)(8936002)(43066004)(106356001)(316002)(66066001)(36756003)(53936002)(50226002)(305945005)(2906002)(50466002)(5660300001)(86362001)(4326008)(3450700001)(81156014)(6512007)(81166006)(446003)(48376002)(7736002)(956004)(2616005)(6486002)(11346002)(6666003)(76176011)(8676002)(25786009)(105586002)(486005)(97736004)(51416003)(3846002)(478600001)(186003)(6116002)(486005)(59450400001)(26005)(68736007)(39060400002)(386003)(6506007)(476003)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR04MB3001; H:otc-sw1.am.freescale.net; FPR:;
 SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; HE1PR04MB3001;
 23:wfV65MO7T+pIsgKllgTV/Rmceek3F3EVitzImaxyZ?=
 =?us-ascii?Q?f76arVwbUiieP2S7Z7q7tVRY+09gvY7rr6Lk1LAH92Ow4QcjfPkVfaMeTqwy?=
 =?us-ascii?Q?qWVrCEksFZaFVBw7WgJ/K/kLydTyl9iExkrmYd/mUloTbdf/CeLu/FCqBeMB?=
 =?us-ascii?Q?ztHKm92P/+PGLuG5t7+RgxeZi/8wKkTh6/4OIeTHANhg0Umcr9CBmnfBGckh?=
 =?us-ascii?Q?CfdI9l4Yw9zX/ga6XfMHPmi9oICP+ahhkZz3mgzLwKiDVREpf5qwLN/zLFYc?=
 =?us-ascii?Q?ervK5TQMRjTvL7UUNKJ8HS6kc4rhypey/uOfMI9+7rB08GRt7xZZYO4BRz+k?=
 =?us-ascii?Q?nDYF638GFpgnguO9lijO73iJqjcdhv3lb4zW2nDIjuGBLWllRLcnTmjvklh4?=
 =?us-ascii?Q?9bXRYJjhjF7l1FP4mSB9HkxhQjQBBN8nBMxHUQSa8gX/NSFhyfmflgyHpHjH?=
 =?us-ascii?Q?H5aNk6czR7eF4b/gSC8M7XdZw2bA+qGWzL1fWbe9qfpu9cwWKDEIqtHm28Uy?=
 =?us-ascii?Q?mBWy5+Ul7vl/zrBBB6g0jicPImeDsO7Dfn0ydLjW+C7W1F0oFrk8thqYAODO?=
 =?us-ascii?Q?QSlRTYF54J1FdsDnQ471E1TGVipJGewjAZFV9oscTrjziZ7okS8nIr5LS8DQ?=
 =?us-ascii?Q?vUMtATYZpxt3V4AJ/yhq/3D9CBid+jqvMYJ8HL6Usx+3EU0ESxMeRIeo7UUM?=
 =?us-ascii?Q?neWNUf24kbPq1fi5NgFL+pZeoBXPVtA40aYNCkD5j1tkr4LWYbDcupODEj1E?=
 =?us-ascii?Q?wJXqlvxfcVtpZC042739oYcGx3nUDTlwgvdPj9l/tyewv3zUiYgM4mSweQ5T?=
 =?us-ascii?Q?TPckR4daJN6FIbJM+NfYhlV3AfNgSlcUrmj74UxzyUa9FuvGU2Yo/1LSFd3Z?=
 =?us-ascii?Q?b/YnYIlD2ehgICLjk/OfHdmfLteubsflI5GYHJ5dJ/qQBzyPrGxKJT4Zjkte?=
 =?us-ascii?Q?gn9bp1tvYqpO99xWVRbQj11hCZZp35ZkPqrbX4nKVMvJ6ZBQ7r5hLikkApwt?=
 =?us-ascii?Q?uuDPludB+mpUiVGypmBZLdtsbcvgg5nZ4M+tzNKJjmwq2ETmGGHh+CBfQD2A?=
 =?us-ascii?Q?NHAo6uTBZnyT1nASNOufjzHp8ojPzFIkwXkljQkSCTePumIisRn3FkKHupdx?=
 =?us-ascii?Q?i30nI9cwwhBloviRAZ7gc7eyJbPgW7HVInvvJMfeifhZtGWl99dZG7vYTHZP?=
 =?us-ascii?Q?fzivujMDskosxAAmni2ikrSh4+EJ0g5JAqnrMz1XwyIxdRy3FSMZT/x+ZwwP?=
 =?us-ascii?Q?cL9Y9/G74nXe0eyzqZkDslsgFeIMTT65bYzLlj8zfXcI9eAuhkAN/7d29fc0?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: yhRzynDGxC8i94RmyS2PIJj2p5heXoetb0UE1QMlVqyEksSdkDbW+y0dHO0IEdI/dKzhwDYZ/pXs/AoB68ZYDCIIDs8ofT37BIqqL7D80UXO2PugGhOoDhpvOxGIjBUXXm/y3MyTexrBQhO1IPg8DONoA8W/oE2pzitp3QrWOqUPqrVwj7iCYK5gPJenr6FW
X-Microsoft-Exchange-Diagnostics: 1; HE1PR04MB3001;
 6:F6agW3No5N6TqUIdshzgGxSQZk+6RfsYJFaTdoo9jXiEE+N9Gxs0yb4CSI50n8pZYMybu3xMnHFNY2+K4U4pqrmhXgtnAM+tZQIrCp+69mwQKNR1ix5GIeub0kPhO4cgTddgNmRAQM3BrjNU0Iez5lzhIv9xz9DUMkHKsPndsL/hWGV4uh/cdMVfCw5npU9avrBa+YSnOIqPcICAuLsfeT1LvzfuTLe7nStSw6zGN17w1fuIj+UsGK1sCYUs+HOzlcEy/s2ee3dPWC6fP+BCNH1U8yQdtK1K179yYH8FQwSoYLDT2tTTAnxEVBla/LzlK/WiTahu502hBfdLTUwi/MUE9dPAIXloTY3ssYDTc1PdrBoZCHEBRm8lrwIv/LHoixvKpr+TqZ+hwDh44/KvxLa8WVT/6j8cfmypHCdqS6hhkw4zkrPmp5BDTuPMPgPAU259ct7wJDENuOPSoOb/cg==;
 5:QhcvdVmUCSgVW0XAIS3cNCn9mpXi91VVKwT2CVb0rElnpw9ITyWCpuFfAemUVamBKcAV8RZqK3xWfg1eOlshcCDChY3XD+aJPqL2uHjUmvXSteJZlo5S51lIVdnUlT3Xbp0nTgRyXnfiSLQ41XBmlmkWGIXxeZrg0y6Miw7bQMw=;
 24:f0Z7ucWSbZjrxNHckcHLK8eqDbikE3UO7wc4T81Bop2P/wE/8HgtMgLvvWKj9n8atjE+8mO+yN127DrPE0TKw6EX33pUMq7K7jBcCAJnPCQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; HE1PR04MB3001;
 7:ZunSebaDxq86yPgmg/TovUPkaWF5WugDycwy2wraHtpqkUuD6itavJM3sCF4QU1DhBmyxXNsCJOL4il/TKrzyBBRSp+rs7glnuuPiD6t4c4qAB7zbTzJdODLB+61kM00m1zxNRg7ODq1ZoLcwmq/PtMGljDfxsSiGH6UlvsFt8boyDInSqMd+g9jS13tYQMwYq2Gy/s2McYQ3pVUoxaBbx0S39wRdCf06ACZPi1XmDhjahz5Q/bRK4R6fURPUrr7
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 18:14:16.8415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5abaf9a-0440-4ba6-ae95-08d5940e8fbd
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

Remove the staging/drivers/fsl-mc directory from the staging
area now that all the components have been moved to the main
kernel areas.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/staging/Kconfig             | 2 --
 drivers/staging/Makefile            | 1 -
 drivers/staging/fsl-mc/Kconfig      | 2 --
 drivers/staging/fsl-mc/Makefile     | 3 ---
 drivers/staging/fsl-mc/bus/Kconfig  | 7 -------
 drivers/staging/fsl-mc/bus/Makefile | 7 -------
 6 files changed, 22 deletions(-)
 delete mode 100644 drivers/staging/fsl-mc/Kconfig
 delete mode 100644 drivers/staging/fsl-mc/Makefile
 delete mode 100644 drivers/staging/fsl-mc/bus/Kconfig
 delete mode 100644 drivers/staging/fsl-mc/bus/Makefile

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index d5926f0..a0f262a 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -98,8 +98,6 @@ source "drivers/staging/clocking-wizard/Kconfig"
 
 source "drivers/staging/fbtft/Kconfig"
 
-source "drivers/staging/fsl-mc/Kconfig"
-
 source "drivers/staging/fsl-dpaa2/Kconfig"
 
 source "drivers/staging/wilc1000/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 919753c..326a1e8 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -40,7 +40,6 @@ obj-$(CONFIG_CRYPTO_SKEIN)	+= skein/
 obj-$(CONFIG_UNISYSSPAR)	+= unisys/
 obj-$(CONFIG_COMMON_CLK_XLNX_CLKWZRD)	+= clocking-wizard/
 obj-$(CONFIG_FB_TFT)		+= fbtft/
-obj-$(CONFIG_FSL_MC_BUS)	+= fsl-mc/
 obj-$(CONFIG_FSL_DPAA2)		+= fsl-dpaa2/
 obj-$(CONFIG_WILC1000)		+= wilc1000/
 obj-$(CONFIG_MOST)		+= most/
diff --git a/drivers/staging/fsl-mc/Kconfig b/drivers/staging/fsl-mc/Kconfig
deleted file mode 100644
index 3002229..0000000
--- a/drivers/staging/fsl-mc/Kconfig
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-source "drivers/staging/fsl-mc/bus/Kconfig"
diff --git a/drivers/staging/fsl-mc/Makefile b/drivers/staging/fsl-mc/Makefile
deleted file mode 100644
index 1468388..0000000
--- a/drivers/staging/fsl-mc/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# Freescale Management Complex (MC) bus drivers
-obj-$(CONFIG_FSL_MC_BUS)	+= bus/
diff --git a/drivers/staging/fsl-mc/bus/Kconfig b/drivers/staging/fsl-mc/bus/Kconfig
deleted file mode 100644
index 90f234d..0000000
--- a/drivers/staging/fsl-mc/bus/Kconfig
+++ /dev/null
@@ -1,7 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# DPAA2 fsl-mc bus
-#
-# Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
-#
-
diff --git a/drivers/staging/fsl-mc/bus/Makefile b/drivers/staging/fsl-mc/bus/Makefile
deleted file mode 100644
index 2141e4b..0000000
--- a/drivers/staging/fsl-mc/bus/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Freescale Management Complex (MC) bus drivers
-#
-# Copyright (C) 2014 Freescale Semiconductor, Inc.
-#
-
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
