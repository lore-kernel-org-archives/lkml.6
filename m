Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AIpwx49VgvI57P07Kdv7+TwcMpDuFap9AHXagkc0Pk6W7oF0zuQl5PC9jx7IDbkwQ3EZT0jwIESm
ARC-Seal: i=1; a=rsa-sha256; t=1523965103; cv=none;
        d=google.com; s=arc-20160816;
        b=xC1O7YVjFxyM1eADMS56oRtfNkRLM3BNLYmADVqOG74S44WkcuOnV393XflCHBLbJ3
         TgTtwOo3OP5kRUeifsKrxPbLuFNlUlMJbiqPxeT6lmmA6r3arbq5epUltO7kBh1ppTWr
         LkLmQ/r+sKH5MAltYnA+1pUKaEOhjJ906NeNpYU36RWe99VbPrrS9dmWLWrRiHdjjD63
         OjhUtc0qXV2NY8HsMnn+9QAkjXbbBqFjort6VDzBNx34/m5YqqS2FWMnHySjF/T4A6Qq
         zabZ9+j8FAVMizLntvMgO5H9WZsJhMUAw6RNnIgHEZkEkR6Gl63I+j5CsDZgVkWcbFkq
         CGdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=6u+BvkYsg7Q4F+8V03FPnAP6b3r4dbQ+QRXdS753+2o=;
        b=H7cLCyHKyHzXk5lzw2mutId4dFyChYhTW+8mCEIxfQ7pdaoiBGDd+/zz0uBcF7UA0Q
         xxB7hx9fzjKtyoYqHpla6zPIhbK4kVE93WES+vO/Z/70FOwomK+4DJjywUyof5sjCczA
         nuKA7odXNs/Tty1qq6N/N/c0VMJ1A2mCmyFp2JLdk8ZLczFK/uakjr6dOZ1J9CEPxqlb
         YjEznI1JBm/THHth+qCEulYe7EjfOpWaybtety5wJGiwKdbPtXWcI2m3bDmN3RVZK67U
         kfmth5q3F7hz5e6+Md+TP6vYeVHgFNTK8JgHDkozBI+XCIbdmzot3nIH6qJrRSfVjFOf
         73Ag==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=SXVcWMzE;
       spf=neutral (google.com: 104.47.37.63 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=SXVcWMzE;
       spf=neutral (google.com: 104.47.37.63 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vijendar.Mukunda@amd.com;
Subject: Re: [alsa-devel] [PATCH 4/4] ASoC: amd: enabling bt i2s config after
 acp reset
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org,
 "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>, Takashi Iwai <tiwai@suse.com>,
 Jason Clinton <jclinton@chromium.org>, Mark Brown <broonie@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, Dylan Reid <dgreid@chromium.org>,
 Akshu Agrawal <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>
References: <1523941201-15665-5-git-send-email-Vijendar.Mukunda@amd.com>
 <201804171833.Rbn5FNLY%fengguang.wu@intel.com>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <3c3e76fe-4b70-3cb2-5658-f9616b168219@amd.com>
Date: Tue, 17 Apr 2018 17:11:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <201804171833.Rbn5FNLY%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [125.21.194.1]
X-ClientProxiedBy: MA1PR0101CA0008.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::18) To DM2PR12MB0316.namprd12.prod.outlook.com
 (2a01:111:e400:50d0::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0316;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0316;3:cGQtrx7dXdGfxg9ddXvHZjSP3K8N3WuUU7Tic76LzGxuCM/+lu2TZaw4FSS52mD88PEC66hUCUBPdgUTiG3f6N7N1ay/j/8xmLofmxm6VGcEjO/DZeVbXWTzCHGVW3eEhBnx/HqrHoD+MAnmZORDU8oDGKvQMpkXPr2K9UUlQREciW50Gdq8bnFgwMCT3zJXfm1XP1ZmJIyIyJpb0d+LscjHaOWAJyJ7lXycV7o8qBNA+NPF+H5bFlMfgHGoxaA1;25:kKFXsZpT6r0BPTn5ZIooq7WGGykgJnTSR4t2fkl74zmHIYcKpNzSR8B1l7oXG88AGrKV5ZA3G5WDOCNtO2/HZ5S2Zi6r/IvT/XIAt51Ue6ip1+34u7TdXbbcQz8EjgocnEr6qyt4vsfe60QP6YoJMr0zKyzILMoXN0KioKCE9qPMoMqlvNRTsmcZU5MBc63FhIzx9XZqxZ/36Uo2KClpl2x1b9SGVUucKrHdN6/dkn84Jv06w05WXdwJB6ufd0phZBOQBlExVjvraixKiZKpfssHrgywJ2YSgU3TJzqnE/EcNJ4bM1MfQPhGY0UR/lc91yzDYMOb+BCFIpPoobCuf8Uz60xTnb2eKaAEJhgMoS0=;31:LyUOb3dYcOgxkwKe8GC6rw4oqYrC+5JKWzvgMkSZGLq/uxXWrqvjb3DP61SqVVVWkIL9yUluCcE9j4QVGz11o0MO7RYGlqbbkQmpVFJH4tRsSscMFg34Ouij69sjW+f6e4tk8P9rEgfTZ7vj6i32/GEk27ZPZakfZraZlmeLV/8omKLire0MDgo5GESB34erj+s+6oBT6GRpnqn5qc8JISoB/hvKBoc1cs/EnvIoG5g=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0316:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0316;20:RtMCCEzyrnP7NsVX4uWjPh4sEiQIilQtzkgo3YXKETH4fgmMe5qiBrGQdcrk9zO9qsQdYZMc7OqsUuuntzOYAXYhpPvh98zrHfJaF0bpXMo8f1HgG0LyJrnyjhucd7ljpvVT7ULHdR+77mc5f7U+cj+TmZmVXRKOeZ+qmi1SQZv4MPhGRjuFQbpzN8MhiV5Ea/mj2zVS5dCAQSFzb6hAF/wpTS1g8UqqHlBGQmwwYRenYRsOCBLyHaHf4bVhg5ft1YMEouQvnFQlZEcAAu/gJYQGwfPKQ3FR1A5dUrkH+puxnObMz5UkIS6A0HUsdiCy0075Yb6D4LLUV/SOadgAVGGwG/5qKr14fLrXx1LT9ocMfofzTUn+BaBgixzlH+lSWd9oQYt+LtSoSH160Hema7YMSsEwQimUY7MrImzOrz0DAmljNpBjZ7ktgxoG7oTBto8Vc5NiN6dFNYF9IB0ho2hq/GhJhnwWCeEiyQV5qRVEZqwNUe8dlsLsv4STdpFi;4:moQs0HE8abzwacXSnawCX3XnNHfB0YLtwnwir7TxFhqOBRcX3DXjwaSbp34mXpEm5D8hoOQ3yotLCzSfZxkw/BuhVAhlhTB1E5laU4RIyhIPIoR8VDxGeauocIp2wL69gAESKzaShYkjWrxjkDORviVDCVIGZh05jn3CikKrX20eEPejX0J2u/M1mX1/pZI2QcTZFsApVmNLJplpFdpLv1+hnXeFOOTMZkM5eYsx6VeA2K/ygm4kgB9GuNDqYNNLdZ3is0bNSCPLub/7RKiJT+vAGcMa4rxrtVsE7Gp1aC0v6IlCe2imJAW5KisP2Ap6a5LdmLQauIhx5DZJMurD0Lyk9nCfiUf+i77PRDly7GXJo28mtegStwc2fw8zqxQ8
X-Microsoft-Antispam-PRVS: <DM2PR12MB0316666A6999214AA9EA8EA797B70@DM2PR12MB0316.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(162533806227266)(84791874153150);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231232)(944501359)(52105095)(10201501046)(6055026)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM2PR12MB0316;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0316;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(346002)(376002)(39380400002)(366004)(396003)(189003)(199004)(7736002)(486006)(229853002)(6666003)(305945005)(446003)(31696002)(11346002)(25786009)(7416002)(50466002)(47776003)(68736007)(106356001)(66066001)(64126003)(65806001)(6246003)(4326008)(105586002)(6306002)(65956001)(76176011)(36756003)(6116002)(39060400002)(6916009)(345774005)(5890100001)(2906002)(97736004)(478600001)(6486002)(230700001)(31686004)(53936002)(966005)(2616005)(956004)(72206003)(476003)(58126008)(16526019)(81166006)(23746002)(81156014)(52116002)(386003)(16576012)(186003)(3846002)(77096007)(54906003)(26005)(8936002)(8676002)(316002)(65826007)(86362001)(67846002)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0316;H:[10.129.12.246];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;DM2PR12MB0316;23:9F+4UPCgdQDl6P52bowAOTT3f5ZmfasZL/gER?=
 =?Windows-1252?Q?CitqoxfPVI9VN/DcSKJkwmmDl51cbSdulDDTC4kUFeNaEIRf3EyRilOU?=
 =?Windows-1252?Q?FlOV15vClLgP3vgAN0fvQ2zCxTQlMCCJD5ZFglbEXCRDEhaT/ycKtzj2?=
 =?Windows-1252?Q?0oEzM9TiAKLBPc0CUCQRFctZKJvjijJjYQskWYlqmQCTF5EXLbK1IF3T?=
 =?Windows-1252?Q?cQGmtX2ZsqD0nU8PYnAKEDiFxk7vZSxsLDOXPuFbkWaoFP18Qa/49Sod?=
 =?Windows-1252?Q?ZozXmso7WA9INLSLxwCA9eyqcKlAi/TlYpQpKX2rajRQ1641CuCaAGNI?=
 =?Windows-1252?Q?VqfHNFc3WT6ySp3fxFZHSGWBPi2P66/gd5aaxnFDahaJ9gMKkPsCh5za?=
 =?Windows-1252?Q?wjmY/vdE3dotNGCPuxGrCF+zb8PP7TBHqsKPM//kQQyzrZXkdCOtJd+3?=
 =?Windows-1252?Q?HEFVZZMXIMFHbgmQ2199Je5eAMl+Bk2E0weoXYafN66BbYpjdaonFVvw?=
 =?Windows-1252?Q?eXT5rSGfuUyVN8fjV6ffXVt/a4FCl/0IKZFo0VX775tKphn6QHrC0jgc?=
 =?Windows-1252?Q?3sKUMCah5Njyd1lFgrHm4PIKmdm3sbtVjPg7ZfYY/BNGuZ0TGREhplr4?=
 =?Windows-1252?Q?SxSTMbgxcccMVVRewLL63OWAQ91Tlv51EAlBy4AwgCTTBL4tGjRedwin?=
 =?Windows-1252?Q?LI147a7tPrHNKzE/GubdxiHZs5Tv4oJcwyAX0giO09OLa1K89ovFEzx6?=
 =?Windows-1252?Q?ndX/DSoGbOzA8UxOn9cZDLE5htip9aaxw+ux81ibmWfhagDtiHnOg34e?=
 =?Windows-1252?Q?3hrqR7tyTNMm14lykw0Ef0wYVkYpCe0mLl4AdlnDVx9t8QFkiguXa8zv?=
 =?Windows-1252?Q?QlSnqM/MMZH0S76CHVDD/9G6AhDehaXd0suFfAC7cye/k73ubH3MkQpl?=
 =?Windows-1252?Q?lCCP2eKClz8c4347GT7sPdwEcDCh8Pp8huLjdHj5XrxOfkBjQVP7Vo9v?=
 =?Windows-1252?Q?okLgT3iHwBXY7ouR6uhyvbJUJrZnwb0qLvbYcxqTtvauNmiDcQap9RQt?=
 =?Windows-1252?Q?BTbUog3T4sS5efH6WTQnlKMNYSPylB2H+mOWQpggi1E1RZkk/KxHCvFQ?=
 =?Windows-1252?Q?7YGM87zO2h60Ck+QpWEfnukFUlpRkM+b/GTWknrvXStdNW9rg+bbGf8Q?=
 =?Windows-1252?Q?fsCJGqymWZ4UoYQhjUGPCXS6rsjeTw3dlez3mdbWqVDT60znjS1Q7iqD?=
 =?Windows-1252?Q?8QPrIm9PouHDovG+wnLzxFQQBojKUcWyqhmaXTKMF5CppWg1rnO1Jeu4?=
 =?Windows-1252?Q?3WwEGTrhuDtUkUnCqceyNGJEZQT0AohruJmq9Z0bJhx1s3AA4dubLye7?=
 =?Windows-1252?Q?lDMwJjZ5fv+Eghb4vIBgudeaR17VJE2HoPJmTSL6Y3oQVlmmJ3v7CXsy?=
 =?Windows-1252?Q?pZ/xNrfRbEWFVsnvLnW/zmbm+ppBFHBEK6hCQEerJEy/tz8cCExSi1rq?=
 =?Windows-1252?Q?ysPyPAcLWK4Df+HrA37Eocx3dygFegINBgmEHI0ZQit8Nrbj5EFH2vfQ?=
 =?Windows-1252?Q?gA3Fgr1di++FvmXWjHfi3wHwEw6DCoSdaq/bFhQ/u3DmXNy3WXSzOah+?=
 =?Windows-1252?Q?PDBSr9ziWCMoRLTk9nH3aXEOIKUjkU2vUFipRqn9jQ8im8iyi8gOSu9R?=
 =?Windows-1252?Q?GigHYOGqg=3D=3D?=
X-Microsoft-Antispam-Message-Info: uNWUeNuOseeOZYi43fcAcjUFgvNnwvndTOLU27QaIq2h+2pALxJAGHSLrEefazKPATQr0zE6CY/AjKadzuasUjok+yG9ze7KY9FFDjo36Bg5AtY2dmRfYPAqcsOk9iN8R0i5vg3/qaNuQcbDb/6oea9lCj0DrbABdDElGihMfejCH1FQmuK4QfG/ozsQoQ94
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0316;6:ePgk18+3FDLLBqMe2fiiSZzwkWDiNi0emGKOA6ukk9OJbFArxKGWpit1WbTOTGMK317zz0Nzu9Osj4ylGw6dWKF7dn9nsVvbSAO3HZROeZua/Z89Xg1FHKZyhtkwk1SOrwqCOmoUDO4mx8h3TPiDNPeA+YBpA3zUxSbS7Ipw5L0hhU2agsPv2jXZSnbTjgU3Qd9PeQOjiMZoi9V4+xCm1ABvUjXHtDemvfg3G9/dzLObnVTnCBxsCAmA41EkTinCNR5IqSHxc3TrSdvwc//mZE5MbYbB4HLcxNoMos5Kf4JJhnd69UDws/K4s062TTbj+87/r+1clf4/e8WjkApHHr8hvSJGNWw7SELKDXgcCIAm3GTSjU0vZphnS0UVEAYkXLLz3jgio88eYpn28L7T9JBghn3+szJHDkngWfQyxdOWH5XPII5HUB/XhWjjBkob53jKDzcX1PSLaTn+tgkVVA==;5:Sy8IxSyIelP+0DAvV9hB9kivEmtrWP+YBrkcnHcaw8ILqmQMxS2UTmpd+2FoNzuY7HSaCRBx9ryh+uQJyorB6vidXX4cEgOU8AtVBnGpkpjNcBdMTgsaUYS2Do1K5pyxvUJjJSBmEtABIG0BnnoPh9ME5iECSEUN3ndi8umMnoQ=;24:q3KqsgGSKQOOkGrTEh7e4FfS4nWunOQctbManjO1v5Ot89rQgq/waPEG3DC4OpsX41lu6yAoCuiaQ5ONm+IRW4EGQnfc3zNUlB4gWcCW+t0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0316;7:sz5cEoBim6vhTZ0v/nAYjPl2nj2+UfTbV3AfuOak05eXBZPW9EXHHsv8oum3bYvWC8F+55Gymg5zsDF/ze7nskxyswlJmCw0HF/BCD6WmbX1rjTYE0j5w+nVWLk7Wgred9VABeBk5YOrA5Y2XVUjBb40kR9Aozj0QIDfRLvB5tPWFdpHQREhQGCkJTW+mbvsbfob3ZshJi9kNHVb/HRPJOSGF+LvG8AFOaIq4Q3lS741O7oCsBbhVlJVBsCJGO6/;20:l9sajL5HyCQ9vWOyTV7GGL8qnGGIpW9biYPeeZRS2tk/KtYLKzBnrfPTSVc/WYongkAVyA21yMm4I9TTnOIdIT8Pi7/AXVuJctEKWvneQ95rAFAxij9jf4hUZtEUAV6efigfOFQY+pWB6D6efNAYhU4TxUS0cigkINKa/fPbDNAwStyLh1K/PcSb54tsAckkW0jyXuodGuzVd0pmTPXWygxiz4cKid1d8xOrEu7LUW9FzN1ke5YAn6tj/fW9U+FZ
X-MS-Office365-Filtering-Correlation-Id: e82532b0-5c5b-417c-c612-08d5a457b809
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 11:38:15.0645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e82532b0-5c5b-417c-c612-08d5a457b809
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0316
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597968144319777100?=
X-GMAIL-MSGID: =?utf-8?q?1597993232941862090?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Tuesday 17 April 2018 04:47 PM, kbuild test robot wrote:
> Hi Vijendar,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on sound/for-next]
> [also build test ERROR on v4.17-rc1 next-20180417]
> [cannot apply to asoc/for-next]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Vijendar-Mukunda/ASoC-dwc-I2S-Controller-instance-param-added/20180417-175408
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
> config: i386-randconfig-x015-201815 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>          # save the attached .config to linux build tree
>          make ARCH=i386
> 
> All errors (new ones prefixed by >>):
> 
>     sound/soc/amd/acp-da7219-max98357a.c: In function 'cz_da7219_init':
>>> sound/soc/amd/acp-da7219-max98357a.c:85:45: error: 'pdev' undeclared (first use in this function); did you mean 'cdev'?
>       bt_pad_enable = device_property_read_bool(&pdev->dev, "bt-pad-enable");
>                                                  ^~~~
>                                                  cdev
>     sound/soc/amd/acp-da7219-max98357a.c:85:45: note: each undeclared identifier is reported only once for each function it appears in
> 
> vim +85 sound/soc/amd/acp-da7219-max98357a.c
> 
>      48	
>      49	static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
>      50	{
>      51		int ret;
>      52		struct snd_soc_card *card = rtd->card;
>      53		struct snd_soc_dai *codec_dai = rtd->codec_dai;
>      54		struct snd_soc_component *component = codec_dai->component;
>      55	
>      56		dev_info(rtd->dev, "codec dai name = %s\n", codec_dai->name);
>      57	
>      58		ret = snd_soc_dai_set_sysclk(codec_dai, DA7219_CLKSRC_MCLK,
>      59					     CZ_PLAT_CLK, SND_SOC_CLOCK_IN);
>      60		if (ret < 0) {
>      61			dev_err(rtd->dev, "can't set codec sysclk: %d\n", ret);
>      62			return ret;
>      63		}
>      64	
>      65		ret = snd_soc_dai_set_pll(codec_dai, 0, DA7219_SYSCLK_PLL,
>      66					  CZ_PLAT_CLK, MCLK_RATE);
>      67		if (ret < 0) {
>      68			dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
>      69			return ret;
>      70		}
>      71	
>      72		da7219_dai_clk = clk_get(component->dev, "da7219-dai-clks");
>      73	
>      74		ret = snd_soc_card_jack_new(card, "Headset Jack",
>      75					SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
>      76					SND_JACK_BTN_0 | SND_JACK_BTN_1 |
>      77					SND_JACK_BTN_2 | SND_JACK_BTN_3,
>      78					&cz_jack, NULL, 0);
>      79		if (ret) {
>      80			dev_err(card->dev, "HP jack creation failed %d\n", ret);
>      81			return ret;
>      82		}
>      83	
>      84		da7219_aad_jack_det(component, &cz_jack);
>    > 85		bt_pad_enable = device_property_read_bool(&pdev->dev, "bt-pad-enable");
>      86	
>      87		return 0;
>      88	}
>      89	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

I will fix it and post the patch as V2 version.
