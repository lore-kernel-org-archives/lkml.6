Return-Path: <anuragku@xilinx.com>
X-Google-Smtp-Source: AG47ELsFx1dI5s7WEFzdHWQGxSKbKDPvBY29A8EFCdC5RfJRJoDEipuPQei5L04u1cmIXjY0GL4/
ARC-Seal: i=1; a=rsa-sha256; t=1521468783; cv=none;
        d=google.com; s=arc-20160816;
        b=ObiLEusHg65lbztInKGUCMb5xJNl459yld37gv2rBc/E+TCv3Z4SP1nObrp1T6teLt
         EVKwYFAFcElD5nD3UFnZFOr1AJwMw3ghDQD8XqvIyckEoKGxspZZYRcjm5TP2QZdm4/t
         WiAcMQ50XGKRfqn+F8CkuCWJXC07Io4pqmtFzfMsINFM9G2M2S8Ain6rKy56k1va1cjT
         Qf8NiqUwzUIVOXLNifsALwnKGE9xnifm4Ml/wQ2v7d0jJG0jjDik1Bxba2Cy3FJBBWNU
         70l5tu+JeJI3c25Es3eSxKp6/VgBsRqMIxaWDhrZFu95tmTBiMyge9g19cSpvOg4lLLI
         rxnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=MzhhRuUPo7/fMwGZdqwtkAPF9OaxI0vmE6CVzk3klyk=;
        b=iEOZElN36obE54STn4FdcyMblZI8HG/g2KONjZpytaOUCorwB5WNQy1LleyyFMJE0/
         fCp4F8YUhV2l4BlJJrtktlK5RAd6AFz6ZZl3oQN4SN+kicZoHKq700adbu5Vm6BjDUmj
         xUWFq/UzlY+32VXFus6r8//OknVPcZatvv82gUuOz8r8PQQruyZP96Ry2IRJcoJBAuvL
         Zy91Wuqv9Z5tKiqg8JTJzpAwqVBSFFgvubrZXYNrSyUAAd4PHriLMSLcR6tfMphBflR8
         HcuZ2PCgte4lDo0KBxKy6XVTwVgOvrual6+lQ8t5LXRrbBqbUlukiye4RxulmJyWv6P/
         cX/w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=cafNCk/r;
       spf=pass (google.com: domain of anuragku@xilinx.com designates 104.47.34.77 as permitted sender) smtp.mailfrom=anuragku@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=cafNCk/r;
       spf=pass (google.com: domain of anuragku@xilinx.com designates 104.47.34.77 as permitted sender) smtp.mailfrom=anuragku@xilinx.com
From: Anurag Kumar Vulisha <anuragku@xilinx.com>
To: Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>, "Ajay Yugalkishore
 Pandey" <APANDEY@xilinx.com>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: dwc3: gadget: Correct the logic for queuing sgs
Thread-Topic: [PATCH] usb: dwc3: gadget: Correct the logic for queuing sgs
Thread-Index: AQHTv07Hj2BDwUGZJ0CZRNZYK+38v6PXQBOAgAAsIoA=
Date: Mon, 19 Mar 2018 14:12:59 +0000
Message-ID: <MWHPR02MB2816D32AE891F329232DA730A7D40@MWHPR02MB2816.namprd02.prod.outlook.com>
References: <1521442253-15906-1-git-send-email-anuragku@xilinx.com>
 <87fu4wqwis.fsf@linux.intel.com>
In-Reply-To: <87fu4wqwis.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2511;7:rhmpZrNvekwdWWwfscABPeE/i71pRJMbyPQE9E6MVQCeJiIop0PS2ekYnGriRIzUSYwMY90hY6GDaLj8vQyVGPTfBO6w33mN2OlD9WsnVCTqyogdmc0qkdyH/Td+qbIXCjLK5CC2h5LDQ9P7tU/ft693Ma69lbcYnq4PimCciViezJtxW4QmWJ+43JVwuIS0GWXeazFWK3LK47zaYijmn0T5D2MhUdoa66dO3+8FYor4g1+UFQFp+5XPgKz2GllB
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 68bd94a4-b8f6-48bb-970e-08d58da384e9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2511;
x-ms-traffictypediagnostic: MWHPR02MB2511:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com;
x-microsoft-antispam-prvs: <MWHPR02MB2511BFD15A6554405BE3F544A7D40@MWHPR02MB2511.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(192813158149592)(36289512736943);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501300)(52105095)(10201501046)(6055026)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR02MB2511;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2511;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(39380400002)(376002)(346002)(13464003)(199004)(189003)(8936002)(5660300001)(4326008)(99286004)(305945005)(106356001)(478600001)(105586002)(6436002)(6116002)(3846002)(33656002)(25786009)(66066001)(7736002)(26005)(74316002)(54906003)(229853002)(2950100002)(110136005)(55016002)(97736004)(5250100002)(81156014)(6246003)(3660700001)(81166006)(55236004)(68736007)(102836004)(8676002)(39060400002)(2900100001)(2906002)(6506007)(76176011)(59450400001)(86362001)(14454004)(9686003)(7696005)(186003)(53936002)(316002)(3280700002)(5890100001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2511;H:MWHPR02MB2816.namprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Pw50RxwwDzGVS3ppMx+yJtPsgiDf23AkIeV95CZAhbKueoRkAavVsORGVkyWv2vLpca5NmNfk4aCQYV55I+AGpIFR1HO0crsiRx3kBBWKoAE7xP8mxf/sCJQBaRU7MecumMdbbbDawGul/BPxpQ9TVNgCvHrtM0Mgf9W8k6iJuAdsLIQjRvjZRcKJUDJ4Po9ixb8kaEQyh7vG7Qc3GSaVmsnGxH1dmEFiugYthYxwD8VZOjx//QqUKcth/XxDM7DG69cvFGmYn8Y8iWoOYyNGoyPNrvngs4+7VbFRq28SJOa8J2+poRlTtlBYa5UT8jC7hJBERbXtmLNYywZ/K3fjQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68bd94a4-b8f6-48bb-970e-08d58da384e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 14:12:59.1254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2511
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595347861307192100?=
X-GMAIL-MSGID: =?utf-8?q?1595375651283173790?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Felipe,

Thanks for reviewing the patch , please find my comments inline

>-----Original Message-----
>From: Felipe Balbi [mailto:balbi@kernel.org]
>Sent: Monday, March 19, 2018 2:21 PM
>To: Anurag Kumar Vulisha <anuragku@xilinx.com>; Greg Kroah-Hartman
><gregkh@linuxfoundation.org>
>Cc: v.anuragkumar@gmail.com; Ajay Yugalkishore Pandey
><APANDEY@xilinx.com>; linux-usb@vger.kernel.org; linux-
>kernel@vger.kernel.org; Anurag Kumar Vulisha <anuragku@xilinx.com>
>Subject: Re: [PATCH] usb: dwc3: gadget: Correct the logic for queuing sgs
>
>
>Hi,
>
>Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com> writes:
>> This patch fixes two issues
>>
>> 1. The code logic in dwc3_prepare_one_trb() incorrectly uses the
>> address and length given in req packet even for scattergather lists.
>> This patch correct's the code to use sg->address and sg->length when
>> scattergather lists are present.
>>
>> 2. The present code correctly fetches the req's which were not queued
>> from the started_list but fails to start from the sg where it
>> previously stopped queuing because of the unavailable TRB's. This
>> patch correct's the code to start queuing from the correct sg in sglist.
>
>these two should be in separate patches, then.
>
Will create separate patches in next version

>> Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
>> ---
>>  drivers/usb/dwc3/core.h   |  4 ++++
>>  drivers/usb/dwc3/gadget.c | 42
>> ++++++++++++++++++++++++++++++++++++------
>>  2 files changed, 40 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h index
>> 860d2bc..2779e58 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -718,7 +718,9 @@ struct dwc3_hwparams {
>>   * @list: a list_head used for request queueing
>>   * @dep: struct dwc3_ep owning this request
>>   * @sg: pointer to first incomplete sg
>> + * @sg_to_start: pointer to the sg which should be queued next
>>   * @num_pending_sgs: counter to pending sgs
>> + * @num_queued_sgs: counter to the number of sgs which already got
>> + queued
>
>this is the same as num_pending_sgs.

num_pending_sgs is initially pointing to num_mapped_sgs, which gets decreme=
nted in dwc3_cleanup_done_reqs(). Consider a case where the driver failed t=
o queue all sgs into TRBs because of insufficient TRB number. For example, =
lets assume req has 5 sgs and only 3 got queued. In this scenario ,when the=
 dwc3_cleanup_done_reqs() gets called the value of  num_pending_sgs =3D 5. =
Since the value of num_pending_sgs is greater than 0, __dwc3_gadget_kick_tr=
ansfer() gets called with num_pending_sgs =3D 5-1 =3D 4 . Eventually __dwc3=
_gadget_kick_transfer()  calls dwc3_prepare_one_trb_sg() which has for_each=
_sg() call which loops for num_pending_sgs times (4 times in our example). =
This is incorrect, ideally it should be called only for 2 times because we =
have only 2 sgs which previously were not queued . So, we added an extra fl=
ag num_queued_sgs which counts the number of sgs that got queued successful=
ly and make  for_each_sg() loop for num_mapped_sgs - num_queued_sgs times o=
nly . In our example case with the updated logic, it will loop for 5 - 3 =
=3D 2 times only. Because of this reason added num_queued_sgs  flag. Please=
 correct me if I am wrong.

>
>>   * @remaining: amount of data remaining
>>   * @epnum: endpoint number to which this request refers
>>   * @trb: pointer to struct dwc3_trb
>> @@ -734,8 +736,10 @@ struct dwc3_request {
>>         struct list_head        list;
>>         struct dwc3_ep          *dep;
>>         struct scatterlist      *sg;
>> +       struct scatterlist      *sg_to_start;
>
>indeed, we seem to need something like this.
>
>>         unsigned                num_pending_sgs;
>> +       unsigned int            num_queued_sgs;
>
>this should be unnecessary.

The explanation given above is valid for this comment also. Please refer th=
e explanation given above

>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 2bda4eb..1cffed5 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -978,11 +978,20 @@ static void dwc3_prepare_one_trb(struct dwc3_ep
>*dep,
>>                 struct dwc3_request *req, unsigned chain, unsigned
>> node)  {
>>         struct dwc3_trb         *trb;
>> -       unsigned                length =3D req->request.length;
>> +       unsigned int            length;
>> +       dma_addr_t              dma;
>>         unsigned                stream_id =3D req->request.stream_id;
>>         unsigned                short_not_ok =3D req->request.short_not_=
ok;
>>         unsigned                no_interrupt =3D req->request.no_interru=
pt;
>> -       dma_addr_t              dma =3D req->request.dma;
>> +
>> +       if (req->request.num_sgs > 0) {
>> +               /* Use scattergather list address and length */
>
>unnecessary comment

Will remove the comment

>
>> +               length =3D sg_dma_len(req->sg_to_start);
>> +               dma =3D sg_dma_address(req->sg_to_start);
>> +       } else {
>> +               length =3D req->request.length;
>> +               dma =3D req->request.dma;
>> +       }
>>
>>         trb =3D &dep->trb_pool[dep->trb_enqueue];
>>
>> @@ -1048,11 +1057,14 @@ static u32 dwc3_calc_trbs_left(struct dwc3_ep
>> *dep)  static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
>>                 struct dwc3_request *req)  {
>> -       struct scatterlist *sg =3D req->sg;
>> +       struct scatterlist *sg =3D req->sg_to_start;
>>         struct scatterlist *s;
>>         int             i;
>>
>> -       for_each_sg(sg, s, req->num_pending_sgs, i) {
>> +       unsigned int remaining =3D req->request.num_mapped_sgs
>> +               - req->num_queued_sgs;
>
>already tracked as num_pending_sgs

The explanation given above is valid for this comment also. Please refer th=
e above mentioned explanation.=20
>
>> +       for_each_sg(sg, s, remaining, i) {
>>                 unsigned int length =3D req->request.length;
>>                 unsigned int maxp =3D usb_endpoint_maxp(dep->endpoint.de=
sc);
>>                 unsigned int rem =3D length % maxp; @@ -1081,6 +1093,16
>> @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
>>                         dwc3_prepare_one_trb(dep, req, chain, i);
>>                 }
>>
>> +               /* In the case where not able to queue trbs for all
>> + sgs in
>
>wrong comment style
>

Will fix this in next version of patch

>> +                * request because of trb not available, update sg_to_st=
art
>> +                * to next sg from which we can start queing trbs once t=
rbs
>> +                * availbale
>                     ^^^^^^^^^
>                     available
>
>sg_to_start is too long and awkward to type. Sure, I'm nitpicking, but sta=
rt_sg
>would be better.

I agree with you, start_sg looks better. Will fix this in next series of pa=
tch
=20
>
>> +                */
>> +               if (chain)
>> +                       req->sg_to_start =3D sg_next(s);
>> +
>> +               req->num_queued_sgs++;
>> +
>>                 if (!dwc3_calc_trbs_left(dep))
>>                         break;
>>         }
>> @@ -1171,6 +1193,8 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep)
>>                         return;
>>
>>                 req->sg                 =3D req->request.sg;
>> +               req->sg_to_start        =3D req->sg;
>> +               req->num_queued_sgs     =3D 0;
>
>num_queued_sgs is unnecessary.

As said in previous explanation, we use num_queued_sgs to  correctly mainta=
in the incomplete sgs. So, clearing it to 0.

>
>>                 req->num_pending_sgs    =3D req->request.num_mapped_sgs;
>>
>>                 if (req->num_pending_sgs > 0) @@ -2327,8 +2351,14 @@
>> static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep
>> *dep,
>>
>>                 req->request.actual =3D length - req->remaining;
>>
>> -               if ((req->request.actual < length) && req->num_pending_s=
gs)
>> -                       return __dwc3_gadget_kick_transfer(dep);
>> +               if (req->request.actual < length ||
>> + req->num_pending_sgs) {
>
>why do you think this needs to be || instead of &&? If actual =3D=3D lengt=
h we're
>done, there's nothing more left to do. If there is either host sent more d=
ata than
>it should, or we miscalculated num_pending_sgs, or we had the wrong length
>somewhere in some TRBs. Either of those cases is an error condition we don=
't
>want to hide. We want things to fail in that case.
>

Consider the same example that we had previously discussed, among the 5 sgs=
 only 3 sgs got queued and all 3 sgs got completed successfully. The req->r=
emaining field represents the size of TRB which was not transferred. In thi=
s example , as 3 sgs got completed successfully the req-> remaining =3D 0. =
So , request.actual =3D length - 0 (req->remaining)  which means request.ac=
tual =3D=3D length.  Because of this , the condition check  if ((req->reque=
st.actual < length) && req->num_pending_sgs) ) fails even though we have re=
q->num_pending_sgs > 0.  So, corrected the logic to always kick transfer fo=
r two conditions 1) if req->num_pending_sgs > 0  2) if ((req->request.actua=
l < length) && req->num_pending_sgs)) condition satisfies. Please correct m=
e If my understanding is wrong.

>> +                       /* There could be cases where the whole req
>> + can't be
>
>wrong comment style.
>
Will correct this in next series of patches

>> +                        * mapped into TRB's available. In that case, we=
 need
>> +                        * to kick transfer again if (req->num_pending_s=
gs > 0)
>> +                        */
>
>also, the code has already been trying to do that. It just wasn't correct.=
 We don't
>need to add this comment.

Added the comment to describe what is happening here. Please let me know if=
 any more information needs to be added or deleted.

>
>> +                       if (req->num_pending_sgs)
>> +                               return
>> + __dwc3_gadget_kick_transfer(dep);
>
>another num_pending_sgs check? Why?

As explained in the previous comment, changed the logic to make it work for=
 two conditions 1) if req->num_pending_sgs > 0  2) if ((req->request.actual=
 < length) && req->num_pending_sgs)) .=20

>
>> This email and any attachments are intended for the sole use of the
>> named recipient(s) and contain(s) confidential information that may be
>> proprietary, privileged or copyrighted under applicable law. If you
>> are not the intended recipient, do not read, copy, or forward this
>> email message or any attachments. Delete this email message and any
>> attachments immediately.
>
>I can't accept ANY patches from you until you remove this footer. In fact,=
 I'm not
>in the To field, so I'm not a "named recipient" and therefore, I'm deletin=
g your
>email. Talk to your IT department about contributing to public mailing lis=
ts.
>
Sorry for the inconvenience caused. Unknowingly , this message got added. I=
 will ensure that this message won't appear in future emails.

Thanks,
Anurag Kumar Vulisha

>Email, now, deleted.
>
>--
>balbi
