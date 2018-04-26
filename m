Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AIpwx487URwe50rj4BU7B7d2GEBZsO4tfmqR0ZnN4OJv19F9zMEqvqb09IOW16vsmn5mBxjzU8kE
ARC-Seal: i=1; a=rsa-sha256; t=1524741520; cv=none;
        d=google.com; s=arc-20160816;
        b=Zg+eOK2v8Yt5k96ggYNxPuir3PHjrl8QxMFR9bqTGhlb5GQ2stsdsyFSTEMgwUoeYx
         /krkoEqWWcp2gVN2Bdxw8pnLl16TG8FVftp8WhuEl3ibz7jB/zo991IHmbZ+JigOBGq6
         c59SnsheFBayvXGrzTsEp+IYg1F55JzfD+sQTgTj11yqACTrCu+6TAU1/Q9K7S8J5LXV
         dr9FwQR0C8m1u2hcHMohgfNutmyRVdodRduYB0OXglOMGesmi23GxQfZFz1fdHV3Pjhj
         wY2VwFSZ25psb7AlTF4KuHTAwiaQz71qK39Py23xrLA/gvh6S7MdmquNggyxLTtEan9/
         +xSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=vGTzWivsYtLaGnuCNLqzfNTdX+ZYomSKSGWDWxDyLWE=;
        b=PmIdlrPD96DK2WXFNE9gDxBkpq7Hn+PmKKs3O/MY6VDi7bVXyzS/DFbcbe6DD8JJ/h
         Q+rVhcNnLh1837ppkHvOPuBIp5SviJ+RwWaz89e3B7QtNgUYRIlPDD1XjmHYuLEO8lY4
         CIuf8TJEnXbXn7BG5DLObmTioiU6bt6yBzYyysrkbb1lvw2d49gcbqohNUxaCX1JsA/u
         glXTO7ZAN48/ed3rf+xWg9/9RrXtv+JcJiXNORLsvni7TmZDMIdA3ezrT4TVse/BWaU/
         EN+w05/IoChtK+aF1OQet9QJrrtKpNKe7MXy03Za8JiRXO3x0ZxIJ/1tJRFKEdiAwaN1
         MvVA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=rGJUq7Bv;
       spf=neutral (google.com: 104.47.42.63 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=rGJUq7Bv;
       spf=neutral (google.com: 104.47.42.63 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=permerror action=none header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: 
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Akshu Agrawal
	<akshu.agrawal@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Kuninori
 Morimoto" <kuninori.morimoto.gx@renesas.com>, Wei Yongjun
	<weiyongjun1@huawei.com>, Jason Clinton <jclinton@chromium.org>, "Guenter
 Roeck" <linux@roeck-us.net>, Kate Stewart <kstewart@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC
 AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 11/11] ASoC: amd: dma driver changes for bt i2s instance
Date: Thu, 26 Apr 2018 16:45:57 +0530
Message-ID: <1524741374-13523-11-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(39380400002)(2980300002)(428003)(189003)(199004)(105586002)(109986005)(72206003)(186003)(51416003)(54906003)(2906002)(7696005)(26005)(53416004)(59450400001)(81166006)(76176011)(97736004)(5660300001)(16586007)(8676002)(305945005)(81156014)(77096007)(50226002)(316002)(7416002)(356003)(36756003)(104016004)(478600001)(106466001)(8936002)(6666003)(68736007)(2616005)(446003)(4326008)(486006)(47776003)(426003)(48376002)(575784001)(336012)(476003)(53936002)(50466002)(126002)(86362001)(11346002)(1671002)(39060400002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM3PR12MB0761;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT052;1:YtmyOY7s6p3Qjp58NXP8FE7kuePZoyF87oUuTdkK2qTUBiAwOqXzLq/9A6yA6md/VPGTB5ElLd0vEUh1gJFchur2g8ysDF+01YDbQCFLIl0WfEfztaX7dVFu6qnEeSrL
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM3PR12MB0761;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0761;3:mIGEQcES02e9Yel8hSVw8QYSGy49XnQ293zbiwjz6QUm0FEVhgDaeAdn1F/rcollcw5wcKpeSs20DrD6ohDjv4OZ8U3NyTmsZtC/jlFTxbjtvO+dFHbSfB7lFbf7pjTne25BW8jEvlGeIZsrbw58Yn90yATbiUzM6xukkGsjfF9TauYW3jp7+XARFxuOYpJxOp1dhJXTrl/gM09pct/UUENiaLRsyThXnB1To1ZPD9kc31sD34EPzqbTxATAtxCqd+A2av4eF2EbPUHu1sRjND2HrP85jx0wsEgHgOMrrmsUZc4DTEU1boX4f1cbGy4qX7EbE2RCJya5xJdysSjtMb91a9cxX2jIxuiQDMJDvHQ=;25:NBF0o+tv8+zlDIhwQWK8hCRWgTt2l+0VVZc0fmDPC1hAiz/8s2Djp44sI4dhK0FIbUfs4KwQmJK9wQ+Uep3ji0XUia8d1lW341Yhf0CCjkahix2jQ0iRr96TMgybg5ngtCdBeiVEUpAAHqAHLhH5Rvw0yRtWSATBRfobNsq8wZ5eiHXHjqEy3gYur0op/MeDUpiZPjwy1cBAcBjXd4wtXbud2xB32+Fg80b00r/YtFecZG/9+GHFOFDppuJ0YVnadoMhUIe6R0Ttol62NjlLTrnAxRNbLse+W/nTOcJ6qlLkewD1vYVf8OIacCU79rAzDKawDc9JS8VUTGFWPomdis9maalNORjYTklPvubBQsI=
X-MS-TrafficTypeDiagnostic: DM3PR12MB0761:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0761;31:RQDJESu9oyWpBXB++qbfrzfcoFO3sI22tqKbWUvvxCdwffJa2IupGJraWq7UqeZzvz/CDQtYZQR5YpPgeCqsoT4W+t6WpBgcuctcGLfvU1jcGxGjvMuIVLuFJbO+3DbTD/Dosr6epgXwUKya2/CxpcdplVP2553XBiSRVnbuVIKsJ8+j+wIq/ZTQcqyjgsdLXKSgQBJDO6Acr/o7PvJYF7SyHm2XrFgoVqH7xh56O3o=;20:ElVpUZfsF7vqwf2SBsG7jPBqth/1hni1ZA6KuUvB8Y+Qoe5HTYnulVxv/A4elnBlsRGUPBeWqz2C0PzdPEm5FCXGap3hCjO3jUX/lPAm2hiZdhBKbAxMhip5i6LKMEtvcQLsGWVR3nlk/Ufv8FuqI7u6oSRX6DMJzoJMaf3mzOFr6nRwSbZYwXGmtNDI0SxLC25PIB2FchzZYlQuxNtpL+h8x/NbQcTCuTil6VoWbyQ9aorU8ciXunpQ867fjL39nQL7eqgK7Dq5YM8ioY6yYwP0vInPT/aJ7SinK8jnUGYn/d0PAs1CVHrepk06R55qNHcnmhe6NM90bGjj00IAjuqgp8OM7FpHX0nlZdjDhnnxhf2UgHDL5liSE9QhGWAMemnElclBey28BRxqXXRexo0BKQoO/SJ7nNm6vpHVFacGbjGUjZ6co55EPl3f+wisjGgjmHdLxBCPG+iatG1mt+SEMWV0fOAxkD2UC1uIFKGmEPisgf2JaAD8vSY0YKQG
X-Microsoft-Antispam-PRVS: <DM3PR12MB0761F00FFC92C17635B13052978E0@DM3PR12MB0761.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501410)(52105095)(93006095)(93003095)(10201501046)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM3PR12MB0761;BCL:0;PCL:0;RULEID:;SRVR:DM3PR12MB0761;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0761;4:ot3pYP+abhci9oQqLIPb5FJGSlNEaNfnKeaEJIILEqaCapSd4g1WW5ejp+oSBBr+DkmISGSoTFZbpldto9tVRfCPApZhmKu92TyuMvkO1YZG3hTHwQepVQHCgybxwCF34wuIpRmk3L7vh9rXBN6uTCAMdANWQEgG0jKRCIG5m6oEWISGAUNE3TToEIbraL4FFU7xT6jRmesvAAa5mS3C/6e24aDfggZHQ0oeI5cnstetTpAJ+aQ5+9cZizMSRizMoTaCu0Nu0ouSYqOzKTFF0AWnljHI+r7seUoYdjGJ7dYfoUIPUOXLqlLguIfjqwE9
X-Forefront-PRVS: 0654257CF5
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR12MB0761;23:mRsdHo9SWM7EU5bZVScuKb4xQcKmXNje0fB27gCPF?=
 =?us-ascii?Q?dJviFKBs0/NgaNWXl422WAjGFzoyGkvg2gKO2/nuflklzg2Q3kP4pvw+tP4o?=
 =?us-ascii?Q?e0f/xn7BTapIsaRlLYEaRYCOkfPDi7xyqol18fC0+ex8vbgdPaoMxOXHbk6M?=
 =?us-ascii?Q?BJyLXqiOamoB9usPXKaxAV1DLDruxU7t0jar5Rr6eeFKofEUPK3GRhH5mX+i?=
 =?us-ascii?Q?9etiiMpJyoM+LWKSZZeY0GaNyznW6305e7wdNNq3CjOvVrhhCakq5jKuNY+f?=
 =?us-ascii?Q?iDU0QJhholi3Ni2ycCMLp7/fGAKjCpHybTYlWonXATPKC7G9ESfHnTjkqIEe?=
 =?us-ascii?Q?Aj/X7IikIMq3GJj1RhRNbjMavMpMyAyN76ziWyn+Vgn2MOsEDPVJ55Wxb2s3?=
 =?us-ascii?Q?5VXRYajFevrvLwNujiWwBfK77BK/0a47z8dugm77Cmyf8PNLBm1jRAcijDS7?=
 =?us-ascii?Q?wpcaZ5NowF5/+2HGx2VbD0kgUQOyasEGmg3xPGNGb0Co2POJfQCC4XG0gA1g?=
 =?us-ascii?Q?z9sxUGq1hWml/RK06tEqyBDvyl+zLBRIWnucjgyQSIQ39aMvl9ydCuD0VIiW?=
 =?us-ascii?Q?2aJfGQKYQxsMEQgCSB0PPrZe5Kh4sSifsk2ViLv7uRaBlp5yCRhdLCoDeUq4?=
 =?us-ascii?Q?Z/IsKEwG45uT4tbmGNglYOkMKtEzOTyiCMj5j/hlMBxZoePrVdsakF1rEILm?=
 =?us-ascii?Q?hxUgyHmpRKZueNt1WqRQrhEV5+e5v6oVfFb11Zeu03tF2we0OmJRJrq9Icxo?=
 =?us-ascii?Q?jybeP8IVuZYr1FQSAVIJge0LzI6Xe4wLh6TgLwlvhFD9PAsaQg3Q2H2zFo1a?=
 =?us-ascii?Q?Qw9loqzXm8lDiRScSNBOhQdQE/EaNGJD/+MnDIrrbXYnW0kIBBqgxmEOgVeS?=
 =?us-ascii?Q?Yk7IgutPagDO3XJ8GP0jTR+vS10IYl829MD1/QMw3Bigu56Sokkze4QhS/2J?=
 =?us-ascii?Q?JOlyJfc5JxQjSyv7Wrv7Iyw5kOe9gcNhgcM3OOdeFVYjUHbpYjqdodEGU/ds?=
 =?us-ascii?Q?Ep19OY4R6yCK26muJRldH00x0J0f/Xr/0pJpPm0ihaDghskvhOv5L6Z2aM0x?=
 =?us-ascii?Q?GBgyre+Rek7kzNWnh63W8q6tgiidD+hW1qGjmn7ul8EnL8qY6X3UGVXItfbT?=
 =?us-ascii?Q?3JKR0kQSehgRPtNQbkSIoSjloH58wjk9O8jz/slbmuR0V0EmlUbduSVW+JWE?=
 =?us-ascii?Q?ARrGA+hpL2t8zd9nFRViskmko0ji1A7YEbNHPhGK1yRFVUoKQc9IiGDgk+uI?=
 =?us-ascii?Q?vIUN+PNCxdfPmddtvozs+mFyI+wWy/hPkDwPuet0bAMNHBtChi+bzJes9umM?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: We8+ItONJhU1REzzbxI8du9elAJex5dT3o2hoZtzRsqj10gDSCNaZ/B+Ze2dlQ33iU0VdQAXT3Xx47GPXtEU88Ut/xDfvlwdvaTFz6gGB5ITZ+jgym3Kd2NJbLA/23/DXEZBE0pFsRRP3Rzz0gJDVlKLu5vefvgv5MvOdkUMbzgoMFF0mN5UAwV89l3wDu2r
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0761;6:+5Cxc/lwd/DXDYuryU9frkERpTVuCxAfKH8ejor3jsWNi8KPCr2an9DDBHrylDvekYcIPbt78I3i3lgd7i/vG9hl767fd7+E82RTB2IqxLm1n0HdIh2/LEA8k5592sT45rpMnBw2oX83UAriadcDHWbsUGoUeprMQpnMwXUMJB8/eBpvf9xjDOkt2LblfWvfEcehz/s4pB4UFaOmoDVucXgglKfOwVBMtWZO0/DAMWA73OpML60tOgTuslUamyp1EZMqOk4Hxs9Sa8UdJ9VlncfwUCseZUpYBn5ZyMxVcVFQiJjnQk667mb6KhBWFe9eDNH5/1qNOAWbSOJzSa6b3rdAVp/41cKDmzHN6Q+D/ft+cDb83tFEqCyw92GN0LZcuRFfbyOfYziJxcx1lrG0I1c7NH6A7wp7tK8vKBtqEfORlhJGiaZlYX0nKFMc6hz5SdTGHDzYlHUrPSlEvHLyUg==;5:APaK40xFcbbMmjdnEQmp6DQn6KkscyLZAmsBEiMKOrIYk+2g96PN5xlOO+jhFXn8gpoLkJhTuRoxC3nmYmLi0tSVD6Wv2eFflZ1geKIUtEEpuZ1ZJTmJZA+Rl0Dgvt6axFack483ZtGoQihVGYt2ydVd3b0urtYzy3jcpuH2SFY=;24:v7HFaJn2o9rRrqISk72OLdOIKuFHTjC/DM0zvHpVG9TarD3rUla0SY9WqD0ZcTMyOkacVWYj9XBkfMBhhk6QvA92CvJXfTSeYQ6N+AXeiC4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0761;7:dKVAV0e/eDs8bSlHcMcnNzpV0r1nS39nANXkYdhHoCWCrDtV5X31IdEJV+KZnItw3isyxFvJNKWYYdtRqPXGp8/y0QJo6HrLsviaT2+aG221YW1HpjUOLkXDedvPFtyVMFYLhbahKca60I8Kv39UAJ8kunLTF2U1Iv4hIKfq5KmwMY8GHLPKLt9nsx2AYxbV3SHMpjR9kg7WFg253HzvpepEdMCUb5TdiZfTX+PF7f3xWQHDybYTLKcI08sHjXsz;20:iF14W+OSyiQwn9l2is0FuATW3m9E3bZWsTBOxOeR2lLrx3sA+QofAIwpzNRDwM1QbdFBc4tyHaA1BwgMms0jCpChOgx85vr2eaYGJmxLkz84BzthQBcbmCMXBHtIrOBQbb8jCltWPp3Il63EXHQVjB6+KIOXTPF9Wl9cUpuGmDlkQy/YRbG/9GvgedtaVMh9AQS5Iq3yJ8LTM2c0/HLVFr9Rf/nw8kUvbxWlF1LeMYSQK6P86qccw/FlkfMbbzWj
X-MS-Office365-Filtering-Correlation-Id: b34745dd-1942-48d0-9968-08d5ab677432
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 11:18:35.7091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b34745dd-1942-48d0-9968-08d5ab677432
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB0761
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598807364015271853?=
X-GMAIL-MSGID: =?utf-8?q?1598807364015271853?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

With in ACP, There are three I2S controllers can be
configured/enabled ( I2S SP, I2S MICSP, I2S BT).
Default enabled I2S controller instance is I2S SP.
This patch provides required changes to support I2S BT
controller Instance.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
v1->v2: defined i2s instance macros in acp header file
v2->v3: sqaushed previous patch series and spilt changes
	into multiple patches (acp dma driver code cleanup
	patches and bt i2s instance specific changes)
 sound/soc/amd/acp-da7219-max98357a.c |  23 ++++
 sound/soc/amd/acp-pcm-dma.c          | 257 +++++++++++++++++++++++++++--------
 sound/soc/amd/acp.h                  |  40 ++++++
 3 files changed, 262 insertions(+), 58 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 133139d..b3184ab 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -36,6 +36,7 @@
 #include <linux/input.h>
 #include <linux/acpi.h>
 
+#include "acp.h"
 #include "../codecs/da7219.h"
 #include "../codecs/da7219-aad.h"
 
@@ -44,6 +45,7 @@
 
 static struct snd_soc_jack cz_jack;
 static struct clk *da7219_dai_clk;
+extern int bt_pad_enable;
 
 static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 {
@@ -132,6 +134,9 @@ static const struct snd_pcm_hw_constraint_list constraints_channels = {
 static int cz_da7219_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
 
 	/*
 	 * On this platform for PCM device we support stereo
@@ -143,6 +148,7 @@ static int cz_da7219_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &constraints_rates);
 
+	machine->i2s_instance = I2S_BT_INSTANCE;
 	return da7219_clk_enable(substream);
 }
 
@@ -153,6 +159,11 @@ static void cz_da7219_shutdown(struct snd_pcm_substream *substream)
 
 static int cz_max_startup(struct snd_pcm_substream *substream)
 {
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
+
+	machine->i2s_instance = I2S_SP_INSTANCE;
 	return da7219_clk_enable(substream);
 }
 
@@ -163,6 +174,11 @@ static void cz_max_shutdown(struct snd_pcm_substream *substream)
 
 static int cz_dmic_startup(struct snd_pcm_substream *substream)
 {
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
+
+	machine->i2s_instance = I2S_SP_INSTANCE;
 	return da7219_clk_enable(substream);
 }
 
@@ -266,10 +282,16 @@ static int cz_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct snd_soc_card *card;
+	struct acp_platform_info *machine;
 
+	machine = devm_kzalloc(&pdev->dev, sizeof(struct acp_platform_info),
+			       GFP_KERNEL);
+	if (!machine)
+		return -ENOMEM;
 	card = &cz_card;
 	cz_card.dev = &pdev->dev;
 	platform_set_drvdata(pdev, card);
+	snd_soc_card_set_drvdata(card, machine);
 	ret = devm_snd_soc_register_card(&pdev->dev, &cz_card);
 	if (ret) {
 		dev_err(&pdev->dev,
@@ -277,6 +299,7 @@ static int cz_probe(struct platform_device *pdev)
 				cz_card.name, ret);
 		return ret;
 	}
+	bt_pad_enable = device_property_read_bool(&pdev->dev, "bt-pad-enable");
 	return 0;
 }
 
diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index aa2fb38..e565cb9 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -37,12 +37,14 @@
 #define MAX_BUFFER (PLAYBACK_MAX_PERIOD_SIZE * PLAYBACK_MAX_NUM_PERIODS)
 #define MIN_BUFFER MAX_BUFFER
 
-#define ST_PLAYBACK_MAX_PERIOD_SIZE 8192
+#define ST_PLAYBACK_MAX_PERIOD_SIZE 4096
 #define ST_CAPTURE_MAX_PERIOD_SIZE  ST_PLAYBACK_MAX_PERIOD_SIZE
 #define ST_MAX_BUFFER (ST_PLAYBACK_MAX_PERIOD_SIZE * PLAYBACK_MAX_NUM_PERIODS)
 #define ST_MIN_BUFFER ST_MAX_BUFFER
 
 #define DRV_NAME "acp_audio_dma"
+bool bt_pad_enable = false;
+EXPORT_SYMBOL(bt_pad_enable);
 
 static const struct snd_pcm_hardware acp_pcm_hardware_playback = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
@@ -357,6 +359,9 @@ static void acp_dma_start(void __iomem *acp_mmio,
 	case ACP_TO_I2S_DMA_CH_NUM:
 	case ACP_TO_SYSRAM_CH_NUM:
 	case I2S_TO_ACP_DMA_CH_NUM:
+	case ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM:
+	case ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM:
+	case I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM:
 		dma_ctrl |= ACP_DMA_CNTL_0__DMAChIOCEn_MASK;
 		break;
 	default:
@@ -519,6 +524,13 @@ static int acp_init(void __iomem *acp_mmio, u32 asic_type)
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
@@ -637,6 +649,24 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
+	if ((intr_flag & BIT(ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM)) != 0) {
+		valid_irq = true;
+		if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_9) ==
+			PLAYBACK_START_DMA_DESCR_CH9)
+			dscr_idx = PLAYBACK_END_DMA_DESCR_CH8;
+		else
+			dscr_idx = PLAYBACK_START_DMA_DESCR_CH8;
+		config_acp_dma_channel(acp_mmio,
+				       SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM,
+				       dscr_idx, 1, 0);
+		acp_dma_start(acp_mmio, SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM,
+			      false);
+		snd_pcm_period_elapsed(irq_data->play_i2sbt_stream);
+		acp_reg_write((intr_flag &
+			      BIT(ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM)) << 16,
+			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
+	}
+
 	if ((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) != 0) {
 		valid_irq = true;
 		if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_15) ==
@@ -659,6 +689,31 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
+	if ((intr_flag & BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) != 0) {
+		valid_irq = true;
+		if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_11) ==
+			CAPTURE_START_DMA_DESCR_CH11)
+			dscr_idx = CAPTURE_END_DMA_DESCR_CH10;
+		else
+			dscr_idx = CAPTURE_START_DMA_DESCR_CH10;
+		config_acp_dma_channel(acp_mmio,
+				       ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM,
+				       dscr_idx, 1, 0);
+		acp_dma_start(acp_mmio, ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM,
+			      false);
+		acp_reg_write((intr_flag &
+			      BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) << 16,
+			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
+	}
+
+	if ((intr_flag & BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) != 0) {
+		valid_irq = true;
+		snd_pcm_period_elapsed(irq_data->capture_i2sbt_stream);
+		acp_reg_write((intr_flag &
+			      BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) << 16,
+			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
+	}
+
 	if (valid_irq)
 		return IRQ_HANDLED;
 	else
@@ -714,11 +769,11 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 	 * This enablement is not required for another stream, if current
 	 * stream is not closed
 	 */
-	if (!intr_data->play_i2ssp_stream && !intr_data->capture_i2ssp_stream)
+	if (!intr_data->play_i2ssp_stream && !intr_data->capture_i2ssp_stream &&
+	    !intr_data->play_i2sbt_stream && !intr_data->capture_i2sbt_stream)
 		acp_reg_write(1, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		intr_data->play_i2ssp_stream = substream;
 		/*
 		 * For Stoney, Memory gating is disabled,i.e SRAM Banks
 		 * won't be turned off. The default state for SRAM banks is ON.
@@ -730,7 +785,6 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 							bank, true);
 		}
 	} else {
-		intr_data->capture_i2ssp_stream = substream;
 		if (intr_data->asic_type != CHIP_STONEY) {
 			for (bank = 5; bank <= 8; bank++)
 				acp_set_sram_bank_state(intr_data->acp_mmio,
@@ -754,6 +808,8 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd,
 								    DRV_NAME);
 	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
+	struct snd_soc_card *card = prtd->card;
+	struct acp_platform_info *pinfo = snd_soc_card_get_drvdata(card);
 
 	runtime = substream->runtime;
 	rtd = runtime->private_data;
@@ -761,52 +817,108 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 	if (WARN_ON(!rtd))
 		return -EINVAL;
 
+	rtd->i2s_instance = pinfo->i2s_instance;
 	if (adata->asic_type == CHIP_STONEY) {
 		val = acp_reg_read(adata->acp_mmio,
 				   mmACP_I2S_16BIT_RESOLUTION_EN);
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			val |= ACP_I2S_SP_16BIT_RESOLUTION_EN;
-		else
-			val |= ACP_I2S_MIC_16BIT_RESOLUTION_EN;
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			switch (rtd->i2s_instance) {
+			case I2S_BT_INSTANCE:
+				val |= ACP_I2S_BT_16BIT_RESOLUTION_EN;
+				break;
+			case I2S_SP_INSTANCE:
+			default:
+				val |= ACP_I2S_SP_16BIT_RESOLUTION_EN;
+			}
+		} else {
+			switch (rtd->i2s_instance) {
+			case I2S_BT_INSTANCE:
+				val |= ACP_I2S_BT_16BIT_RESOLUTION_EN;
+				break;
+			case I2S_SP_INSTANCE:
+			default:
+				val |= ACP_I2S_MIC_16BIT_RESOLUTION_EN;
+			}
+		}
 		acp_reg_write(val, adata->acp_mmio,
 			      mmACP_I2S_16BIT_RESOLUTION_EN);
 	}
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		switch (adata->asic_type) {
-		case CHIP_STONEY:
-			rtd->pte_offset = ACP_ST_PLAYBACK_PTE_OFFSET;
+		switch (rtd->i2s_instance) {
+		case I2S_BT_INSTANCE:
+			rtd->pte_offset = ACP_ST_BT_PLAYBACK_PTE_OFFSET;
+			rtd->ch1 = SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM;
+			rtd->ch2 = ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM;
+			rtd->sram_bank = ACP_SRAM_BANK_3_ADDRESS;
+			rtd->destination = TO_BLUETOOTH;
+			rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH8;
+			rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH9;
+			rtd->byte_cnt_high_reg_offset =
+				mmACP_I2S_BT_TRANSMIT_BYTE_CNT_HIGH;
+			rtd->byte_cnt_low_reg_offset =
+				mmACP_I2S_BT_TRANSMIT_BYTE_CNT_LOW;
+			adata->play_i2sbt_stream = substream;
 			break;
+		case I2S_SP_INSTANCE:
 		default:
-			rtd->pte_offset = ACP_PLAYBACK_PTE_OFFSET;
+			switch (adata->asic_type) {
+			case CHIP_STONEY:
+				rtd->pte_offset = ACP_ST_PLAYBACK_PTE_OFFSET;
+				break;
+			default:
+				rtd->pte_offset = ACP_PLAYBACK_PTE_OFFSET;
+			}
+			rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
+			rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
+			rtd->sram_bank = ACP_SRAM_BANK_1_ADDRESS;
+			rtd->destination = TO_ACP_I2S_1;
+			rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
+			rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
+			rtd->byte_cnt_high_reg_offset =
+				mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
+			rtd->byte_cnt_low_reg_offset =
+				mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
+			adata->play_i2ssp_stream = substream;
 		}
-		rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
-		rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
-		rtd->sram_bank = ACP_SRAM_BANK_1_ADDRESS;
-		rtd->destination = TO_ACP_I2S_1;
-		rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
-		rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
-		rtd->byte_cnt_high_reg_offset =
-		mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
-		rtd->byte_cnt_low_reg_offset = mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
 	} else {
-		switch (adata->asic_type) {
-		case CHIP_STONEY:
-			rtd->pte_offset = ACP_ST_CAPTURE_PTE_OFFSET;
-			rtd->sram_bank = ACP_SRAM_BANK_2_ADDRESS;
+		switch (rtd->i2s_instance) {
+		case I2S_BT_INSTANCE:
+			rtd->pte_offset = ACP_ST_BT_CAPTURE_PTE_OFFSET;
+			rtd->ch1 = ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM;
+			rtd->ch2 = I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM;
+			rtd->sram_bank = ACP_SRAM_BANK_4_ADDRESS;
+			rtd->destination = FROM_BLUETOOTH;
+			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH10;
+			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH11;
+			rtd->byte_cnt_high_reg_offset =
+				mmACP_I2S_BT_RECEIVE_BYTE_CNT_HIGH;
+			rtd->byte_cnt_low_reg_offset =
+				mmACP_I2S_BT_RECEIVE_BYTE_CNT_LOW;
+			adata->capture_i2sbt_stream = substream;
 			break;
+		case I2S_SP_INSTANCE:
 		default:
-			rtd->pte_offset = ACP_CAPTURE_PTE_OFFSET;
-			rtd->sram_bank = ACP_SRAM_BANK_5_ADDRESS;
+			rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
+			rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
+			switch (adata->asic_type) {
+			case CHIP_STONEY:
+				rtd->pte_offset = ACP_ST_CAPTURE_PTE_OFFSET;
+				rtd->sram_bank = ACP_SRAM_BANK_2_ADDRESS;
+				break;
+			default:
+				rtd->pte_offset = ACP_CAPTURE_PTE_OFFSET;
+				rtd->sram_bank = ACP_SRAM_BANK_5_ADDRESS;
+			}
+			rtd->destination = FROM_ACP_I2S_1;
+			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
+			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
+			rtd->byte_cnt_high_reg_offset =
+				mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
+			rtd->byte_cnt_low_reg_offset =
+				mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
+			adata->capture_i2ssp_stream = substream;
 		}
-		rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
-		rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
-		rtd->destination = FROM_ACP_I2S_1;
-		rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
-		rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
-		rtd->byte_cnt_high_reg_offset =
-		mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
-		rtd->byte_cnt_low_reg_offset = mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
 	}
 
 	size = params_buffer_bytes(params);
@@ -991,24 +1103,39 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		adata->play_i2ssp_stream = NULL;
-		/*
-		 * For Stoney, Memory gating is disabled,i.e SRAM Banks
-		 * won't be turned off. The default state for SRAM banks is ON.
-		 * Setting SRAM bank state code skipped for STONEY platform.
-		 * added condition checks for Carrizo platform only
-		 */
-		if (adata->asic_type != CHIP_STONEY) {
-			for (bank = 1; bank <= 4; bank++)
-				acp_set_sram_bank_state(adata->acp_mmio, bank,
-							false);
+		switch (rtd->i2s_instance) {
+		case I2S_BT_INSTANCE:
+			adata->play_i2sbt_stream = NULL;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			adata->play_i2ssp_stream = NULL;
+			/*
+			 * For Stoney, Memory gating is disabled,i.e SRAM Banks
+			 * won't be turned off. The default state for SRAM banks
+			 * is ON.Setting SRAM bank state code skipped for STONEY
+			 * platform. Added condition checks for Carrizo platform
+			 * only.
+			 */
+			if (adata->asic_type != CHIP_STONEY) {
+				for (bank = 1; bank <= 4; bank++)
+					acp_set_sram_bank_state(adata->acp_mmio,
+								bank, false);
+			}
 		}
 	} else  {
-		adata->capture_i2ssp_stream = NULL;
-		if (adata->asic_type != CHIP_STONEY) {
-			for (bank = 5; bank <= 8; bank++)
-				acp_set_sram_bank_state(adata->acp_mmio, bank,
-							false);
+		switch (rtd->i2s_instance) {
+		case I2S_BT_INSTANCE:
+			adata->capture_i2sbt_stream = NULL;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			adata->capture_i2ssp_stream = NULL;
+			if (adata->asic_type != CHIP_STONEY) {
+				for (bank = 5; bank <= 8; bank++)
+					acp_set_sram_bank_state(adata->acp_mmio,
+								bank, false);
+			}
 		}
 	}
 
@@ -1016,7 +1143,8 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 	 * Disable ACP irq, when the current stream is being closed and
 	 * another stream is also not active.
 	 */
-	if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream)
+	if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream &&
+	    !adata->play_i2sbt_stream && !adata->capture_i2sbt_stream)
 		acp_reg_write(0, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 	kfree(rtd);
 	return 0;
@@ -1070,6 +1198,8 @@ static int acp_audio_probe(struct platform_device *pdev)
 
 	audio_drv_data->play_i2ssp_stream = NULL;
 	audio_drv_data->capture_i2ssp_stream = NULL;
+	audio_drv_data->play_i2sbt_stream = NULL;
+	audio_drv_data->capture_i2sbt_stream = NULL;
 
 	audio_drv_data->asic_type =  *pdata;
 
@@ -1126,6 +1256,7 @@ static int acp_pcm_resume(struct device *dev)
 {
 	u16 bank;
 	int status;
+	struct audio_substream_data *rtd;
 	struct audio_drv_data *adata = dev_get_drvdata(dev);
 
 	status = acp_init(adata->acp_mmio, adata->asic_type);
@@ -1145,9 +1276,8 @@ static int acp_pcm_resume(struct device *dev)
 				acp_set_sram_bank_state(adata->acp_mmio, bank,
 							true);
 		}
-		config_acp_dma(adata->acp_mmio,
-			       adata->play_i2ssp_stream->runtime->private_data,
-			       adata->asic_type);
+		rtd = adata->play_i2ssp_stream->runtime->private_data;
+		config_acp_dma(adata->acp_mmio, rtd, adata->asic_type);
 	}
 	if (adata->capture_i2ssp_stream &&
 	    adata->capture_i2ssp_stream->runtime) {
@@ -1156,9 +1286,20 @@ static int acp_pcm_resume(struct device *dev)
 				acp_set_sram_bank_state(adata->acp_mmio, bank,
 							true);
 		}
-		config_acp_dma(adata->acp_mmio,
-			       adata->capture_i2ssp_stream->runtime->private_data,
-			       adata->asic_type);
+		rtd =  adata->capture_i2ssp_stream->runtime->private_data;
+		config_acp_dma(adata->acp_mmio, rtd, adata->asic_type);
+	}
+	if (adata->asic_type != CHIP_CARRIZO) {
+		if (adata->play_i2sbt_stream &&
+		    adata->play_i2sbt_stream->runtime) {
+			rtd = adata->play_i2sbt_stream->runtime->private_data;
+			config_acp_dma(adata->acp_mmio, rtd, adata->asic_type);
+		}
+		if (adata->capture_i2sbt_stream &&
+		    adata->capture_i2sbt_stream->runtime) {
+			rtd = adata->capture_i2sbt_stream->runtime->private_data;
+			config_acp_dma(adata->acp_mmio, rtd, adata->asic_type);
+		}
 	}
 	acp_reg_write(1, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 	return 0;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 62695ed..9cd3e96 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -13,6 +13,8 @@
 /* Playback and Capture Offset for Stoney */
 #define ACP_ST_PLAYBACK_PTE_OFFSET	0x04
 #define ACP_ST_CAPTURE_PTE_OFFSET	0x00
+#define ACP_ST_BT_PLAYBACK_PTE_OFFSET	0x08
+#define ACP_ST_BT_CAPTURE_PTE_OFFSET	0x0c
 
 #define ACP_GARLIC_CNTL_DEFAULT			0x00000FB4
 #define ACP_ONION_CNTL_DEFAULT			0x00000FB4
@@ -46,8 +48,13 @@
 
 #define TO_ACP_I2S_1   0x2
 #define TO_ACP_I2S_2   0x4
+#define TO_BLUETOOTH   0x3
 #define FROM_ACP_I2S_1 0xa
 #define FROM_ACP_I2S_2 0xb
+#define FROM_BLUETOOTH 0xb
+
+#define I2S_SP_INSTANCE                 0x01
+#define I2S_BT_INSTANCE                 0x02
 
 #define ACP_TILE_ON_MASK                0x03
 #define ACP_TILE_OFF_MASK               0x02
@@ -68,6 +75,14 @@
 #define ACP_TO_SYSRAM_CH_NUM 14
 #define I2S_TO_ACP_DMA_CH_NUM 15
 
+/* Playback DMA Channels for I2S BT instance */
+#define SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM  8
+#define ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM 9
+
+/* Capture DMA Channels for I2S BT Instance */
+#define ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM 10
+#define I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM 11
+
 #define NUM_DSCRS_PER_CHANNEL 2
 
 #define PLAYBACK_START_DMA_DESCR_CH12 0
@@ -80,9 +95,23 @@
 #define CAPTURE_START_DMA_DESCR_CH15 6
 #define CAPTURE_END_DMA_DESCR_CH15 7
 
+/* I2S BT Instance DMA Descriptors */
+#define PLAYBACK_START_DMA_DESCR_CH8 8
+#define PLAYBACK_END_DMA_DESCR_CH8 9
+#define PLAYBACK_START_DMA_DESCR_CH9 10
+#define PLAYBACK_END_DMA_DESCR_CH9 11
+
+#define CAPTURE_START_DMA_DESCR_CH10 12
+#define CAPTURE_END_DMA_DESCR_CH10 13
+#define CAPTURE_START_DMA_DESCR_CH11 14
+#define CAPTURE_END_DMA_DESCR_CH11 15
+
 #define mmACP_I2S_16BIT_RESOLUTION_EN       0x5209
 #define ACP_I2S_MIC_16BIT_RESOLUTION_EN 0x01
 #define ACP_I2S_SP_16BIT_RESOLUTION_EN	0x02
+#define ACP_I2S_BT_16BIT_RESOLUTION_EN	0x04
+#define ACP_BT_UART_PAD_SELECT_MASK	0x1
+
 enum acp_dma_priority_level {
 	/* 0x0 Specifies the DMA channel is given normal priority */
 	ACP_DMA_PRIORITY_LEVEL_NORMAL = 0x0,
@@ -95,6 +124,7 @@ struct audio_substream_data {
 	struct page *pg;
 	unsigned int order;
 	u16 num_of_pages;
+	u16 i2s_instance;
 	u16 direction;
 	u16 ch1;
 	u16 ch2;
@@ -113,10 +143,20 @@ struct audio_substream_data {
 struct audio_drv_data {
 	struct snd_pcm_substream *play_i2ssp_stream;
 	struct snd_pcm_substream *capture_i2ssp_stream;
+	struct snd_pcm_substream *play_i2sbt_stream;
+	struct snd_pcm_substream *capture_i2sbt_stream;
 	void __iomem *acp_mmio;
 	u32 asic_type;
 };
 
+/*
+ * this structure used for platform data transfer between machine driver
+ * and dma driver
+ */
+struct acp_platform_info {
+	u16 i2s_instance;
+};
+
 union acp_dma_count {
 	struct {
 	u32 low;
-- 
2.7.4
