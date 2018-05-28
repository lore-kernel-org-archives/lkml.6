Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933476AbeE1ShJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 14:37:09 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47990 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933255AbeE1ShG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 14:37:06 -0400
From: Song Liu <songliubraving@fb.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: Tariq Toukan <tariqt@mellanox.com>, Song Liu <liu.song.a23@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>, "Kernel Team" <Kernel-team@fb.com>
Subject: Re: WARNING and PANIC in irq_matrix_free
Thread-Topic: WARNING and PANIC in irq_matrix_free
Thread-Index: AQHT9GSPvVlQSgBGI0+pRnF2w/wY8aRE+2SAgAAGngCAADUVAIAARdAA
Date: Mon, 28 May 2018 18:36:52 +0000
Message-ID: <095C8C48-56BC-43E0-8885-17D9F3F569FB@fb.com>
References: <e2ec1a14-326a-57c2-56a6-7c2235e5b8b3@mellanox.com>
 <alpine.DEB.2.21.1802201829180.24268@nanos.tec.linutronix.de>
 <CAJwJo6aeb2q-C1R2MBnQQ8yR+7Xy4FWqSmBCE=7CkK_OHNCqSQ@mail.gmail.com>
 <alpine.DEB.2.21.1805191319190.1599@nanos.tec.linutronix.de>
 <16f47fa4-1555-cddb-3dfb-7d56fb992ea1@mellanox.com>
 <alpine.DEB.2.21.1805231049021.1598@nanos.tec.linutronix.de>
 <CAPhsuW7PPRfPYfCtBMsOYdGJCkPKsVNU0501RFKdECvadhOu3w@mail.gmail.com>
 <alpine.DEB.2.21.1805281251140.1578@nanos.tec.linutronix.de>
 <1b4ded38-f217-fafa-d920-cddf980a685c@mellanox.com>
 <alpine.DEB.2.21.1805281625260.1584@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1805281625260.1584@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.6.18)
x-originating-ip: [2620:10d:c090:180::1:be]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1903;7:0aB8kP/ZoAvv1IIYK1lUxCQp2UvTUVrlVaOg5T3d+gkPr9sHLsgV8noYPrFjeAzeBog4WBwOnJTJuS/YISg+rNxg7dnQkCt3NDhYh9zR+lxOYW7t3tFgOVFLg/YJjzU7o5CNxIQzAavtAvWgVkHi4teGIyHy9MynPGiykjUpo4dVrX9zMKFQOleU3yCxiDAayu94icV02d/xoIqj9CgT13jAlDnh1moW7QURafhs284X+PFGvyoCofLoJ8Q3fJEv;20:EC2cnNIedRdrr7rPm5EC8l748USd9YB2bBZWF+d+k7Pwbn51Pw4uYKAiHAiWrvqdYYPtIXXQ+FB0cd72WPZ9PyAlgCniWmXIL3zFTwIdgEDsWuP753k3rMYviZp3Wun5lzHGMeuOii6a2goa+egkuO9FostvAMnU9Jh1H8GpSI4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1903;
x-ms-traffictypediagnostic: MWHPR15MB1903:
x-microsoft-antispam-prvs: <MWHPR15MB1903E977058A1A21D7205E4BB36E0@MWHPR15MB1903.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231254)(11241501184)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR15MB1903;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1903;
x-forefront-prvs: 06860EDC7B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(396003)(346002)(39860400002)(199004)(189003)(6436002)(8936002)(476003)(7736002)(305945005)(6486002)(229853002)(33656002)(2616005)(39060400002)(446003)(46003)(5250100002)(11346002)(36756003)(93886005)(57306001)(82746002)(8676002)(81166006)(86362001)(2900100001)(486006)(81156014)(316002)(54906003)(6916009)(5660300001)(478600001)(99286004)(106356001)(105586002)(50226002)(6512007)(83716003)(76176011)(6506007)(102836004)(53546011)(59450400001)(68736007)(25786009)(6246003)(6116002)(14454004)(53936002)(97736004)(2906002)(4326008)(3660700001)(3280700002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1903;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: oBLw3lSfeaZCg9zq+M0OrHaPTjozCs82rbLR5yasouuR5kFW0EzqwkoltYazz3QpNqxY6VTbdiElvtIPsMzcmkB68Ja+v7uBYo8wsEbLsU/gcqT2jdlI3E4wTT+qeLI0oHY6Dq4n8ExYBCwXcKdn6gYhqvudiBIjacWnHOt1F+DXIQk2d/xoq2fokZjEF9TP
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2DA92A3CFE2A254BA5D847C0B52A2156@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 08f11466-4257-4e79-8bc8-08d5c4c9fb86
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f11466-4257-4e79-8bc8-08d5c4c9fb86
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2018 18:36:52.9068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1903
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-28_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4SIbh7u019872



> On May 28, 2018, at 7:27 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> On Mon, 28 May 2018, Tariq Toukan wrote:
>> On 28/05/2018 1:53 PM, Thomas Gleixner wrote:
>>> On Fri, 25 May 2018, Song Liu wrote:
>>>> On Wed, May 23, 2018 at 1:49 AM, Thomas Gleixner <tglx@linutronix.de>
>>>> wrote:
>>>>> On Wed, 23 May 2018, Tariq Toukan wrote:
>>>>>> I have your patch merged into my internal branch, it prints the
>>>>>> following:
>>>>>> 
>>>>>> [ 4898.226258] Trying to clear prev_vector: 0
>>>>>> [ 4898.226439] Trying to clear prev_vector: 0
>>>>>> 
>>>>>> i.e. vector(0) is lower than FIRST_EXTERNAL_VECTOR.
>>>>> 
>>>>> Could you please enable the vector and irq matrix trace points and
>>>>> capture
>>>>> the trace when this happens?
>>> 
>>> Does the patch below fix it?
>>> 
>>> Thanks,
>>> 
>>> 	tglx
>>> 
>>> 8<-------------------
>>> diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
>>> index bb6f7a2148d7..54af3d4884b1 100644
>>> --- a/arch/x86/kernel/apic/vector.c
>>> +++ b/arch/x86/kernel/apic/vector.c
>>> @@ -148,6 +148,7 @@ static void apic_update_vector(struct irq_data *irqd,
>>> unsigned int newvec,
>>>  	 * prev_vector for this and the offlined target case.
>>>  	 */
>>>  	apicd->prev_vector = 0;
>>> +	apicd->move_in_progress = false;
>>>  	if (!apicd->vector || apicd->vector == MANAGED_IRQ_SHUTDOWN_VECTOR)
>>>  		goto setnew;
>>>  	/*
>>> 
>> 
>> I took it into my internal branch. Will let you know.
> 
> Note, I'd still like to see a trace w/o the patch which shows which order
> of events leads to this. Even if the patch cures it, it might just paper
> over it and not fixing the root cause.
> 
> Thanks,
> 
> 	tglx

I just checked trace without the patch. It looks the same as the one with
the patch. 

Thanks,
Song
