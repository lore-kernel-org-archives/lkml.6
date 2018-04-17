Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AIpwx4/02piGo0ZQSkXvT9oEuPIgUWexKca6lNOCNFQPvTXsSjvm+5nSnvlyaibJcbD/fImn9HWM
ARC-Seal: i=1; a=rsa-sha256; t=1523980146; cv=none;
        d=google.com; s=arc-20160816;
        b=gnQICRO94qw5SSe2omygdTYL1aivTOh8BdM/MDdg6FQrKmHUKt99P0oHNYpY9LEO4X
         TOyCk9KF7DBxKCVFUPc5pNmiB4mQzWOc4OFAIfqRkSf3U5pAv1ahBr1wCJvAoq1fwC43
         LNCPhiZ5FfZVHOk5stKPdukWMpCaFcT/5aE6zqgx3V8G8KHLP6rL1KP+9UX2Bv7Qqurt
         +XPWINVIvvTLRyIzwOwb5CGqMEGHuMCnk2m4x9jxZLNJeaqu1+qiuvrHIvtQ8xDFM+dx
         mCZte+TtuQxPtDZ92Irak9IL8X4M+GyH+/aBfg/WIhGgYLQzG1ShmljfIQUdxF1zUTKc
         fSUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=LsS1FaXbFleERLL26vkCEBKXqXeE/PglJIj5cS4Rw6I=;
        b=jvkD1ah3wmpqmzYQEgnf1sB6jtSHcf1vE5QahbrkdWt5bkU8Xk8ZDsSuzuwc3nIo+z
         lBh5hDDi5XUWy+c6uaBheki/Sg3Y+pogn370tylJxNg0QwyAXblHv9b4K0DBJTJ96kEM
         1y5eBVb17q7fFtV0QrQ16B8lk04+c37hAvR8f1YvkNOn4gQt1npk1EPcJuks+YCbO0Us
         3VLbKkdRbCjAuo6coPGQZnuHNM1JhPDgTcUQPG/7EI7+ShFPlVAkNgCBZOTweV8U2KA8
         4zIXpHaIAEeBhLr3jHUjimjIbfTP3a8zGi3TdaRytOE85TRyMC/SqkvsHnE5M79AvpvM
         46gA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=wH/a9Wtd;
       spf=neutral (google.com: 104.47.36.54 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=wH/a9Wtd;
       spf=neutral (google.com: 104.47.36.54 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=permerror action=none header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: 
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Akshu Agrawal
	<akshu.agrawal@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Alex
 Deucher <alexander.deucher@amd.com>, Dylan Reid <dgreid@chromium.org>, Jason
 Clinton <jclinton@chromium.org>, Guenter Roeck <linux@roeck-us.net>, Thomas
 Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC
 AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2 4/4] ASoC: amd: enabling bt i2s config after acp reset
Date: Tue, 17 Apr 2018 21:21:45 +0530
Message-ID: <1523980325-4242-1-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523941201-15665-5-git-send-email-Vijendar.Mukunda@amd.com>
References: <1523941201-15665-5-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(396003)(39380400002)(2980300002)(428003)(199004)(189003)(81156014)(81166006)(77096007)(72206003)(16586007)(478600001)(54906003)(106466001)(4326008)(316002)(8676002)(39060400002)(356003)(104016004)(2906002)(109986005)(68736007)(53416004)(53936002)(97736004)(47776003)(6666003)(105586002)(8936002)(86362001)(336012)(76176011)(7416002)(11346002)(36756003)(1671002)(446003)(126002)(486006)(2616005)(50226002)(476003)(305945005)(426003)(50466002)(26005)(186003)(5660300001)(51416003)(48376002)(7696005)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0321;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT028;1:L+BIY0TZ2lwUvUeqw6+2MncKOwSQs1JVp9lObI5SvZ5pcypDp0PYkur/9oJs5SgRhjn/QQGenlLKk2CUzPKCiKVlrLgYzQXcvncRqPj+75z7+kh5P45P1w9BJrCCjj22
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BY2PR12MB0321;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0321;3:qm2JjVjMrA3cFzl5uE8+lPYEoiP+2cyZVHPQsQlulI+Rsr8ttSk7PMVSI8XiYWoNzjuJZUG5VXyWXvwIGoU/hZGyPMSaTbr7zCDU8OQTwAnYxrXJ6aVA2SFtDBeLA1fA764t4z1gaImaww5dj9t2DMjNv9aaLWkqbUe0xoRjKeuqNjC7XI+9VXLOY4koWp0FAI7+JOcG91JBqm8SeEOKS7y0K/4yyKR54lJRwvgN5o3jO7YuMzIWVLYwU5MX0Ti47L3lfTpRivZYIBF6Mc+ZbGkYX4sdLWWKRbxk533OMIf3o3glbDRClJ2TEm6ZHx+2WuQ6SkN2PV743jTJuPvkF9LuJQzhM3wg9oUIxZQKnjM=;25:lQ0IZf3RrLg8h5Q0ATwJc40N8ZW66EXtdzUsMM1ZrlkWH1MyhQBsJ3prMfa0CdkVHj6F7CaLtAxUllj6nLY7Ff3e177rNRJDN4afDLkg3l+S9CoyFGc/s+JJhv/XPVYYAd/Kia4579hql00su/+09edaHPnnra/8mIZiengosfmURMDUDWbWNpxOoBsuos0qsO3lVjIZhnhpXSIfftkHsHaImRJjBy05aWr74jYZ7c1kRy5VWt9i0XO82a5E77bFT58xnMrJuviq54ddcZ66sNTCnfvs/wPNx5JlfTuW8u4dzX6DixKzOT6iApF1vJ30JM73Cs+5L/VHa9NB9qXyAg==
X-MS-TrafficTypeDiagnostic: BY2PR12MB0321:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0321;31:n1MGQcqnJLgro/coXyEZ7uUgVc2vE1kwby5Ef01qUGgvB2AXqpZy+2AJ8kpiE1aKZzXlBm6SpkBrsGlz+4IgrqPTNRakskzhn8Hx2NnTefM6NwPZkT26lf6JWoRxELt8zVoGN1iLPj469cTmUvA6YitopMbyKBYoyVGt4GS5BfIbm9Jl/eFlZY3IFSKOpYnzR02sLO+3A4bZ/+Dr0BIaNlY98a+KsXbosXeEsaMJOjQ=;20:VchhzF6LiBLDUHHdBGmyuqSqVXYkx4WwRKiuGP8kccpHRL5aT6CQZ6oskaQDJC1lllFwZvtI8u6fLeh/0CxRdZCBEqyBk+CksvR4ts+y22lTOjAzoBR7ly0UrPdCB2cK3rpTmEMenoJgfNXqkWYeAlxNgowQQcbY5P7ZmNBMfam0wR6KRPWbTaotGKnVfBAvaA+blfYBDDhdrR1QcffvC2UlciRCjLIzAbJEBwZOigzSSz92xxeNYA1fi9iEoUzZhjFHZxni6iDotJLixCGXRI0djOYFPGsEQNfRLi6ebDYme3Onakde9LXE1ukD5EwIDmCZoq8MtcXHvH15qHlYEySEB/XjzLPhOLeDxpUtCtxvBcwut7235J+zqeaybwFOSSQkNC5dmfVHD+mH8UVkgGw2ayLCb+i9Qlw6F6RCum6g/TIccRv5ok4Uii5gFnf2C1Y30BUbFtgna3CJbOCpGR9PYgODwo/LMlNKc9+A6vedB0Op9HJqeE8TH2oN16PL
X-Microsoft-Antispam-PRVS: <BY2PR12MB03213A3C05A773D3D0CDB56097B70@BY2PR12MB0321.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231232)(944501327)(52105095)(93006095)(93003095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BY2PR12MB0321;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0321;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0321;4:yAKJiRqIhQeTTVlV0AFBIVE6/0dU+4CLNlhrg+BbSqlxu/LeR3elAgTecLRk3rkp7hqiFivb5+333ksN0L3Poi6mZ+HDr1Adbuz0jh6pVnJMWYVyrzkrufU4BwC/IvVDQ678tCWpRCiLG20tRyROYdimnaSr6uva8c+ILR1popFuNWItxguZ5uk3+tGORaogBr4B8fDP8VforMByxr+IV/7GEuBNUj9FDoJ9XbID0MAjh7wguFMNt8AXa0ScBQ9ZfpL2Vehyz0ANWpZxHFS2SVRNojygdtophdW7zbEn8lozsdHh8J3yVy1Kn12WbLdb
X-Forefront-PRVS: 0645BEB7AA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR12MB0321;23:ngYIYMOxq/1Asl4QK4covBvwafb+Hwbsckx6yiL48?=
 =?us-ascii?Q?girzCj7OfxlsEDQgCUpL0bg9pDBrD6wAZfbGzkgi3Oaickiv//IFqjevHjUA?=
 =?us-ascii?Q?V0Agf7kQ+bO8gWic9XJ1IkmXRArWljFRKBlARrNhs/tiEZHRGbP9uU6z3duQ?=
 =?us-ascii?Q?r1V5TklledIw1LxJ1Hqr+TM6bniNnIEQeWFLiSKO3feVwvUKKVf3yMOv18ZW?=
 =?us-ascii?Q?fym+oIJvaoynjMsM5Bql4nfzBDVor4xo3Rkyly+oC4goRHLHGWnP6HWySEsM?=
 =?us-ascii?Q?gKP7pft/dtS/rNRNQiPMPgLCnJm4VPHedXtrONpposhOV3EpJhtNaULx3f6N?=
 =?us-ascii?Q?N+e9Uz6q1+we1Ffk7BYPUh+N/0rxrV0cciigrIpPR2yoGaUsMJ5jklCZ15UP?=
 =?us-ascii?Q?ix/z/+7x5m4sYgkHRhA8aiFmKSaDvxyji4iVnZqNbDWGlzXMINTLBi8BI4X+?=
 =?us-ascii?Q?AlxSNy2/+1gz/AE2IqkYE+9bks5pN+0ymHzYfd31/FrTzKq+o4oSGc11XCNs?=
 =?us-ascii?Q?LSpjEwWaS2aXSNa+kvITFKc2aqASKMR6IvvTn7n2xhAm0P4y6VGmm8uYa6fA?=
 =?us-ascii?Q?r6wzb9hPF9cayw1nH2pBIOGoDXlfrixpJAkin39rRG7Db9RKJBRJ/Tym7a0l?=
 =?us-ascii?Q?kgIkIhPDZ4DASU7kIhE1hCUJfTq8WHMnoJKfn2kazn3E+mUPLssCYwC66ear?=
 =?us-ascii?Q?ydSUcxh7KJWzeOmbIDFrnFexAHvzsutsUnPecpG/WtzYt/4VyJxWLGOLzIUG?=
 =?us-ascii?Q?bj2CjX80lyvtgCwFM7qVEY75DUpQIn289KixRF47mTMlM/akj4jFAYmKMIhZ?=
 =?us-ascii?Q?K8WJ0vh10ABhFebYF93nVutneFOab0BZhaNkVszAdy+gMI8wKb4R/Ql2U+9t?=
 =?us-ascii?Q?7rGiWHE+ZvWSuWk5c0MTqndVa1DKQQj3TSIV45KCheRnjeAddq9jRrWdTqW8?=
 =?us-ascii?Q?IbI2PmzZvIJNWQMHZwE9xT4AWju+/98QtKM4xsp29csNSJTtU8VHVljxazMB?=
 =?us-ascii?Q?UasZ7C5d3i6wQW09mPdbt5b41c4VI5SyC5KTGKJU+MFSXQzfesk97g9vLss9?=
 =?us-ascii?Q?LOFT/j4eAkPKmJnUMGlxT4mgl4qjpUzxHyF3SY0KA86la7CyjKLbOYua22Sq?=
 =?us-ascii?Q?GluRaWRd/CNpIeonu/+axri7IDVQID2VLCEy6ikZXsDUmuoW9NoIJBnWnGyt?=
 =?us-ascii?Q?WiAd6Hm1GSndyVFuxjZcdOvHTG4+o0GpGvUIjjOZiYRrbBJALHYHSGMqLNQb?=
 =?us-ascii?Q?qXyZm0uqRQmIUcGgqw=3D?=
X-Microsoft-Antispam-Message-Info: axExJDy8iUlwZCr8mr9D9povjTFSnkdfOOQlrj36pFNcFg6Fkln5416MGUnPanJWF2mi6qDAPonKB5J8StJP/7pjYVolH503oXa6GfKZvCbDv6T4hmZx1AUBgaVdAF9pQajAtBsozpDSubWx3xy27W0l4JhpLwf0tb+oQSVFT2Hs0g9qTQtoHBtuB6I3hY4o
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0321;6:fB1Y6Um47R5Tr+inqrMxHoT5E8vQg3bF2YAT8kVj61AGm1aemede+FQ5mgVnfXXO4S/xcpTtI1LOW0cMihFvU3w8zuYLEhGGJLfhIFicRbZlirg4rhUXXqQt7o/BT/+QFyiLRqDllFCxvWIz3BILTyjvLsdNv3DoeAAyHKKckvsaLgNir6bZiIjzvPLwbKwL1lnir3n68+4eCUGPz3gdJzhIXWYbkLmUVXpOUtFKdDaPyEQcbBVNdSf1Ga0acn3tCvC4kI7qrthc5CWxsFOQ8JiLxwPkTpQ6UGymTUqScZGMms3a4HrCETuZnJQztlJTVmj/ftf4i3kXwZuf2L/unnmocZkTeMnqgAMvinQHJvhQuRkQ5yJT4iDuPHzzT3uhLsG6fnX7aVhlrIa8Dp3WCww3zoqzQxsSpjuGf0xVGU71yR4KAjVOFrmgsyyqUEJCF0ouE7vPQBi6HbifgUhzTg==;5:bign7n8b+71H8n/tTwiknRASBu3eY5tREFM2gueVDQD4X/B7r+iETPoRl03NFO2vgCXGBTM04BCMgWtab2pcGnKpK/oAYdzZPjrzfA6tycKQkmi/uodxgIwqqo/RJbSR9KmaEhg9oauDdAHenirzg7vVQqHUD2lTQNoq/SzPf/s=;24:aE5jzlDY7vWkiqTEG9D44XFk4KtlG+W3EGcBuw/GAUXvjH1OoFuDqy0N24LhhHopyx1YIkzJXUiOlGkPhZfU7kjcAjhNWjvK9sSIqwVPsOw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0321;7:1Cw/wRIIpPFJRZWJA5qOvlz1DDUOM0k8WXu9Z9gOA4TrLh9mlxJR7Lyqy4eUlDQR7TinEXRbiJIAapUMjVKegeHheStEMwqhnAxHXOIfqpJ1DNc0kvSAjSXtDMx4mrtCQYzep2+TmtEA7hHI5jBqw8weHsxGku/EviKaPYKNFA90lNmLut8+zDT1Bg8f3UTYazPpEXXfkhw2mhXRispU5WVC9JUyOb01ZQ+87obzR3vsE9gET2cQls5F9XBC9Pwi;20:BQwWYenk9TmEn8NJTQ6B5Pxk1tF3eFQ9SfzVboLoz47LQT0FfLjWPXR4TKvxGdeaOxnrUVeLSlw9VEQ53F2TWZp31AMAq6vYXdPFkz5cl3SJ2BT3zCGJUS/idT0MyPC6jLmOpc7FulxCqC4HckkBLOdiLHYf9qUAn/k8dgPCCmu7OVCENPb1IsO2qiJfNfjgKIR2QVXhHAb9gwlsedlFiuMp17WwEnArQxyyfywdrzSr7uRtogdA5omPQsEyKMvO
X-MS-Office365-Filtering-Correlation-Id: a1037825-672b-467e-8e85-08d5a47abdc0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 15:49:01.3490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1037825-672b-467e-8e85-08d5a47abdc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0321
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597968144319777100?=
X-GMAIL-MSGID: =?utf-8?q?1598009006206256186?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On ST/CZ based platforms, for specific platform bt uart
mux to be defined for bt i2s.
By default, these pins will be used for uart.
After acp reset , it requires to reprogram bt i2s config
mux pins to enable bt i2s instance.
added bt i2s enablement sequence during acp init.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>

v1->v2: fixed kbuild errors
---
 sound/soc/amd/acp-da7219-max98357a.c | 2 ++
 sound/soc/amd/acp-pcm-dma.c          | 9 +++++++++
 sound/soc/amd/acp.h                  | 1 +
 3 files changed, 12 insertions(+)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index b205c78..9ff2138 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -44,6 +44,7 @@
 
 static struct snd_soc_jack cz_jack;
 struct clk *da7219_dai_clk;
+extern int bt_pad_enable;
 
 static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 {
@@ -251,6 +252,7 @@ static int cz_probe(struct platform_device *pdev)
 				cz_card.name, ret);
 		return ret;
 	}
+	bt_pad_enable = device_property_read_bool(&pdev->dev, "bt-pad-enable");
 	return 0;
 }
 
diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 7c392fe..b52c660 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -46,6 +46,8 @@
 
 #define DRV_NAME "acp_audio_dma"
 
+bool bt_pad_enable = false;
+EXPORT_SYMBOL(bt_pad_enable);
 
 static const struct snd_pcm_hardware acp_pcm_hardware_playback = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
@@ -525,6 +527,13 @@ static int acp_init(void __iomem *acp_mmio, u32 asic_type)
 	val &= ~ACP_SOFT_RESET__SoftResetAud_MASK;
 	acp_reg_write(val, acp_mmio, mmACP_SOFT_RESET);
 
+	/* For BT instance change pins from UART to BT */
+	if (bt_pad_enable) {
+		val = acp_reg_read(acp_mmio, mmACP_BT_UART_PAD_SEL);
+		val |= ACP_BT_UART_PAD_SELECT_MASK;
+		acp_reg_write(val, acp_mmio, mmACP_BT_UART_PAD_SEL);
+	}
+
 	/* initiailize Onion control DAGB register */
 	acp_reg_write(ACP_ONION_CNTL_DEFAULT, acp_mmio,
 		      mmACP_AXI2DAGB_ONION_CNTL);
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 460365c..6b43144 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -107,6 +107,7 @@
 #define ACP_I2S_MIC_16BIT_RESOLUTION_EN 0x01
 #define ACP_I2S_SP_16BIT_RESOLUTION_EN	0x02
 #define ACP_I2S_BT_16BIT_RESOLUTION_EN	0x04
+#define ACP_BT_UART_PAD_SELECT_MASK	0x1
 
 enum acp_dma_priority_level {
 	/* 0x0 Specifies the DMA channel is given normal priority */
-- 
2.7.4
