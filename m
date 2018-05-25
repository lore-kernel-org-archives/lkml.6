Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030559AbeEYVxm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 17:53:42 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45428 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1030394AbeEYVxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 17:53:40 -0400
From: Song Liu <songliubraving@fb.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH, net-next 1/2] bpf: btf: avoid -Wreturn-type warning
Thread-Topic: [PATCH, net-next 1/2] bpf: btf: avoid -Wreturn-type warning
Thread-Index: AQHT9HAeHmBMspT3K0mRxe5qBEwilqRA/KeA
Date: Fri, 25 May 2018 21:53:11 +0000
Message-ID: <97F843D7-7E81-44B3-AE97-112ABFE8E892@fb.com>
References: <20180525213331.2115471-1-arnd@arndb.de>
In-Reply-To: <20180525213331.2115471-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.6.18)
x-originating-ip: [2620:10d:c090:200::7:1409]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1421;7:0aDEH8/NWrvGsKvImb8DNxkMSuA5PiCwzI/RrT5JQDLZrFBRSaei7xy0ZvTMc9QT/spesxTy2IMRtWvgZcuVVn14S9e3Y/L5u2dLE+aBPEAT2Ql3/dFs0P1Ky6WTgeoTdQPZU1aLRujaLNnb5UPjWELmrNPWJ8Te0Xx2rPjjCz3xNHDCh1EbWyFfuUT1f1FVIJ8e9ltq91sSwLOGxhEsuFKGFEvWButrsVitG37afiZujG8M2orQ6dR4nhXJPGij;20:rYbWYQSoTnb3CDdGRWgrbiB9A5XFLXrhcIpNcQVpkrWU8Cn8frGp2UrVrp7CHwpBsnDetkHWePO84/jzSjym5VBSqo8TZZeVFaLOurZO6OPc5d7wnLe24xsq0O+FybsnYnOTZrCCEAqfG4y5EmZaE+2yKLzzTvcIZgjsSqQqViY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(39380400002)(366004)(199004)(189003)(478600001)(57306001)(14454004)(105586002)(97736004)(83716003)(7736002)(2900100001)(575784001)(305945005)(86362001)(46003)(36756003)(446003)(8936002)(5250100002)(3660700001)(3280700002)(50226002)(8676002)(81166006)(81156014)(486006)(6116002)(11346002)(476003)(2616005)(59450400001)(76176011)(186003)(99286004)(316002)(54906003)(102836004)(53546011)(6506007)(6916009)(2906002)(68736007)(82746002)(5660300001)(229853002)(33656002)(4326008)(25786009)(106356001)(6246003)(53936002)(6512007)(6486002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1421;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1421;
x-ms-traffictypediagnostic: MWHPR15MB1421:
x-microsoft-antispam-prvs: <MWHPR15MB1421102FC8DF30734A153E3FB3690@MWHPR15MB1421.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231254)(11241501184)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR15MB1421;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1421;
x-forefront-prvs: 06833C6A67
x-microsoft-antispam-message-info: Zcd5DCqjj1HzC5DTY563DyKq8UP7wK5X5Zi8xI4nz/OjOCtpSCjPl4U1dg2YaFnYw2fcZ3QoUjeetIpuIs0qQc7QuRMbmXF7j+3up8lIq7OiQwkkCdVmwpYOml92Qm+gYkQTDogTgKe90oDI6CXAb8xEzU+uVywHHHcCSQwCQsHdegBZjdTu7br9K3eCrkUz
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <31735B12AA337744AA1A4DF0AE6B59F9@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 3b38675c-2b01-49d5-c088-08d5c289e8d6
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b38675c-2b01-49d5-c088-08d5c289e8d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2018 21:53:11.3614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1421
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-25_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4PLrqGH024651



> On May 25, 2018, at 2:33 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> gcc warns about a noreturn function possibly returning in
> some configurations:
> 
> kernel/bpf/btf.c: In function 'env_type_is_resolve_sink':
> kernel/bpf/btf.c:729:1: error: control reaches end of non-void function [-Werror=return-type]
> 
> Using BUG() instead of BUG_ON() avoids that warning and otherwise
> does the exact same thing.
> 
> Fixes: eb3f595dab40 ("bpf: btf: Validate type reference")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> kernel/bpf/btf.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 9cbeabb5aca3..2822a0cf4f48 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -749,7 +749,7 @@ static bool env_type_is_resolve_sink(const struct btf_verifier_env *env,
> 			!btf_type_is_array(next_type) &&
> 			!btf_type_is_struct(next_type);
> 	default:
> -		BUG_ON(1);
> +		BUG();
> 	}
> }
> 
> -- 
> 2.9.0
> 

Acked-by: Song Liu <songliubraving@fb.com>
