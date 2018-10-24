Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39991ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF49206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="aeX7Y5jP";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="SMeXTMNR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF49206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbeJYBzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:55:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55350 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726716AbeJYBzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:55:45 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9OHNd9i008811;
        Wed, 24 Oct 2018 10:26:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=YuYU1UeQFk7+gzBKbnBNfCl90ZBVJ1O/IuWqVSAZ+3I=;
 b=aeX7Y5jPURxOggtIN/gQBhLThEb0WA0pzzKw2II7sCDrlTYvMSpn8mhSET53BdF8AuTX
 y8a++zN/VgwtgdvYQTEi2iO3Zl27f/uj0g6JmgCwY7PnZDieovbaDD53GzVq3NhQsENI
 oT3vZ7kos1xbW1v/fhOAh/aFMeycjr7iA7Q= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2navrvr36d-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 24 Oct 2018 10:26:27 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 24 Oct 2018 10:26:25 -0700
Received: from PRN-CHUB12.TheFacebook.com (2620:10d:c081:35::21) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Wed, 24 Oct 2018 10:26:25 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.22) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 24 Oct 2018 10:26:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuYU1UeQFk7+gzBKbnBNfCl90ZBVJ1O/IuWqVSAZ+3I=;
 b=SMeXTMNRSRdan/DykkUqzHxPSb00jBaSz2kLKbHNZivZg/55wJKL+T7S46Tntny+gASLT/FCOiaGjfUAIaSszWzCd5Me1Vy2ueJ3eeyihDR/FXJch7JDckf+PJfaPLyyDjUQq7CvtwB/vhrzy4Te1UJcIU7B6yheoCPU+4OsS6I=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1933.namprd15.prod.outlook.com (10.174.100.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Wed, 24 Oct 2018 17:26:23 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::c56f:45c:1647:a419]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::c56f:45c:1647:a419%3]) with mapi id 15.20.1250.028; Wed, 24 Oct 2018
 17:26:23 +0000
From:   Martin Lau <kafai@fb.com>
To:     Wenwen Wang <wang6495@umn.edu>
CC:     Kangjie Lu <kjlu@umn.edu>, Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <netdev@vger.kernel.org>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] bpf: btf: Fix a missing-check bug
Thread-Topic: [PATCH v2] bpf: btf: Fix a missing-check bug
Thread-Index: AQHUa5mXie9xmsybbEORoB7Wt/lhG6UupdqA
Date:   Wed, 24 Oct 2018 17:26:23 +0000
Message-ID: <20181024172514.l33dsaqdvs5yewvm@kafai-mbp>
References: <1540386020-30680-1-git-send-email-wang6495@umn.edu>
In-Reply-To: <1540386020-30680-1-git-send-email-wang6495@umn.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR18CA0043.namprd18.prod.outlook.com
 (2603:10b6:320:31::29) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:be1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1933;20:EaM+7CcWkvPP8ewMvYZpzEDJAPktYhIpk0eq4D0hbmFDszBzc7JHe/03sSKKMjw9NWdAIBAzy/jbXGkynbTGDaCr2E2t9YOhW3BU9vQuZX2lG1nDCSs8ezlttxaYYklmpDjiGxqKIDfsx6c2u83E9Gl8rqB3N8TWgK+OvY/VzH0=
x-ms-office365-filtering-correlation-id: 3c0a8bd9-6e2f-4293-65e4-08d639d5be26
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1933;
x-ms-traffictypediagnostic: MWHPR15MB1933:
x-microsoft-antispam-prvs: <MWHPR15MB1933879CB04AB9CAF3DCCC43D5F60@MWHPR15MB1933.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705)(67672495146484)(8104003914727);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(11241501184)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1933;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1933;
x-forefront-prvs: 083526BF8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(376002)(366004)(39860400002)(136003)(346002)(199004)(189003)(8676002)(33716001)(102836004)(6246003)(86362001)(71190400001)(71200400001)(256004)(14444005)(486006)(68736007)(11346002)(46003)(186003)(5660300001)(2906002)(106356001)(476003)(105586002)(99286004)(2171002)(5250100002)(6436002)(4326008)(2900100001)(9686003)(97736004)(6512007)(316002)(6116002)(6486002)(386003)(6506007)(53936002)(305945005)(446003)(14454004)(52116002)(76176011)(33896004)(478600001)(7736002)(229853002)(54906003)(1076002)(8936002)(81156014)(25786009)(6916009)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1933;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dQFnzNQzAFSG0UihG4A9oaNm+aj8iqxmF+PahQbg9hKEaaQOW0Z0jnuj0mLsTor96iP5BRnAYQbeRXrSs7nPVOdp3gN7UQWw5OJf7xYG5B1Yr1JsVEKIQI2QKtrESMZD6ms2uvYPEKXO0p5A5iVNAuDIXhioH+VOAg3g4l7II1cTM5rnIWLTkC1/dmCcz9Tn0Uuvxw/RGdJX/aalD3MQG9v2HRv/7tElFFkTYFF8NKW13AJvGMDwxnZYO8xIsiMBb6TVZNOkfCNqnq0YRtTb6HiScpEW+f8Px0bucfcZv1o+LWDbux38hiqI23hBxQ3qNKkxAgxqiW5EVtOc/QTB5floS8VWiW5L6lPQaJLSKhs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32582C3EAD0EF042A9F65FD82CB626DE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0a8bd9-6e2f-4293-65e4-08d639d5be26
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2018 17:26:23.2850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1933
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-24_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 08:00:19AM -0500, Wenwen Wang wrote:
> In btf_parse(), the header of the user-space btf data 'btf_data' is first=
ly
> parsed and verified through btf_parse_hdr(). In btf_parse_hdr(), the head=
er
> is copied from user-space 'btf_data' to kernel-space 'btf->hdr' and then
> verified. If no error happens during the verification process, the whole
> data of 'btf_data', including the header, is then copied to 'data' in
> btf_parse(). It is obvious that the header is copied twice here. More
> importantly, no check is enforced after the second copy to make sure the
> headers obtained in these two copies are same. Given that 'btf_data'
> resides in the user space, a malicious user can race to modify the header
> between these two copies. By doing so, the user can inject inconsistent
> data, which can cause undefined behavior of the kernel and introduce
> potential security risk.
>=20
> To avoid the above issue, this patch copies the parsed header from
> 'btf->hdr' to 'data'. The remaining part in 'data' is still copied from t=
he
> user-space 'btf_data'.
LGTM.

Acked-by: Martin KaFai Lau <kafai@fb.com>

>=20
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  kernel/bpf/btf.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 378cef7..b52a834a 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -2152,6 +2152,7 @@ static struct btf *btf_parse(void __user *btf_data,=
 u32 btf_data_size,
>  	struct btf_verifier_env *env =3D NULL;
>  	struct bpf_verifier_log *log;
>  	struct btf *btf =3D NULL;
> +	u32 hdr_len;
>  	u8 *data;
>  	int err;
> =20
> @@ -2200,7 +2201,15 @@ static struct btf *btf_parse(void __user *btf_data=
, u32 btf_data_size,
>  	btf->data_size =3D btf_data_size;
>  	btf->nohdr_data =3D btf->data + btf->hdr.hdr_len;
> =20
> -	if (copy_from_user(data, btf_data, btf_data_size)) {
> +	/*
> +	 * The header at btf_data could be modified by a malicious user
> +	 * after it is parsed. So we copy the parsed header here. The
> +	 * remaining part is still copied from btf_data.
> +	 */
> +	hdr_len =3D min_t(u32, btf->hdr.hdr_len, sizeof(btf->hdr));
> +	memcpy(data, &btf->hdr, hdr_len);
> +	if (copy_from_user(data + hdr_len, (u8 __user *)btf_data + hdr_len,
> +				btf_data_size - hdr_len)) {
>  		err =3D -EFAULT;
>  		goto errout;
>  	}
> --=20
> 2.7.4
>=20
