Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751590AbeEVRWk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:22:40 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:16034 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbeEVRWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:22:37 -0400
X-IronPort-AV: E=Sophos;i="5.49,430,1520870400";
   d="scan'208";a="80339900"
From: Adam Manzanares <Adam.Manzanares@wdc.com>
To: Jens Axboe <axboe@kernel.dk>, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "bcrl@kvack.org" <bcrl@kvack.org>
CC: "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "jack@suse.cz" <jack@suse.cz>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "hch@infradread.org" <hch@infradread.org>,
        "jmoyer@redhat.com" <jmoyer@redhat.com>
Subject: Re: [PATCH v6 2/5] fs: Convert kiocb rw_hint from enum to u16
Thread-Topic: [PATCH v6 2/5] fs: Convert kiocb rw_hint from enum to u16
Thread-Index: AQHT8d6qqRDQDKdV5U2KRWEM4J9p4qQ74G4AgAAOkoCAAAGvAIAADoAA
Date: Tue, 22 May 2018 17:22:33 +0000
Message-ID: <7bc8b818-7eb4-98ab-7af1-82bcc5f37ab7@wdc.com>
References: <20180522150737.9893-1-adam.manzanares@wdc.com>
 <20180522150737.9893-3-adam.manzanares@wdc.com>
 <11fb2ee5-8352-2d35-3154-68637d99b096@kernel.dk>
 <084d253c-52ab-7b23-521c-28602c56153b@suse.de>
 <58087b03-a3c7-93fd-d1ad-de77181e8806@kernel.dk>
In-Reply-To: <58087b03-a3c7-93fd-d1ad-de77181e8806@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Adam.Manzanares@wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR04MB3772;7:3yJvEFikgA7d2uEELrzqXzNKL7IAUzZgU4I1A3khi1yTQKVylxJQqU7fHyG2heU1RrGAZPojiJRJzvNSl/fjdM+S942UYuwWcuHIV2kVGqKM8Ee+t+hzwf12VHONoJJ+Px3ZX//pdS6KH7s57s6cFXPcWZdSWr+WGozqwenFOx6nX0hT2dFiJuHT/5QQNHSrWWRk5qJsDRineu7ywqFqwbSs3ESljy3UMpLXmP/jtHG4fdA2vwCe9PKrnEH5sga+;20:tkDtYvRVVtH23cIBgx2umTa6yuIqxxxLz30EUui2P6EBNtH1q/AXbZiMn8SE37HWdxnK0Ahw3+tMGgcu1a4/07wOjTybTrYhLdqfx4HcbNtbYVf2J0fujGV7MHKMhTWChn6TZOz8TsB3+Xr/jnr0fT+OrehiD6VNbWhfkI0SX+c=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR04MB3772;
x-ms-traffictypediagnostic: DM5PR04MB3772:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM5PR04MB3772D6F4ED322915936E5429F0940@DM5PR04MB3772.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR04MB3772;BCL:0;PCL:0;RULEID:;SRVR:DM5PR04MB3772;
x-forefront-prvs: 0680FADD48
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(366004)(346002)(189003)(199004)(105586002)(76176011)(3660700001)(106356001)(102836004)(2900100001)(53546011)(6506007)(316002)(81156014)(54906003)(110136005)(99286004)(3280700002)(59450400001)(81166006)(66066001)(2501003)(31686004)(7416002)(2906002)(229853002)(8936002)(5250100002)(8676002)(4326008)(6246003)(6486002)(93886005)(6436002)(305945005)(53936002)(68736007)(36756003)(2201001)(31696002)(186003)(86362001)(25786009)(478600001)(476003)(2616005)(14454004)(11346002)(575784001)(486006)(97736004)(3846002)(6116002)(72206003)(6512007)(26005)(5660300001)(7736002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR04MB3772;H:DM5PR04MB0282.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: p7SGwn840hiBiuST2VBY+DmY0D4ACvxnNREkmSyCOwRjY67kXssRm80QrlawkJiIQJOPNllviAk08iCa/KFH7d+gUMmf7l+8/9t9LWYuKJM7k17XpJW8Bh99cOQtxXb5nn6tTZ5EO0+TOBovilp4eW0ZMD6JC9NCPMWE8H7DXbTQeulLuXdH7PM2OgMx1USC
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D0BE8A058A2F64A8E151D2E2039B312@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: acb63543-0bab-4da2-802c-08d5c0089ae7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb63543-0bab-4da2-802c-08d5c0089ae7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2018 17:22:33.2521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB3772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4MHMmQE019844



On 5/22/18 9:30 AM, Jens Axboe wrote:
> On 5/22/18 10:24 AM, Goldwyn Rodrigues wrote:
>>
>>
>> On 05/22/2018 10:32 AM, Jens Axboe wrote:
>>> On 5/22/18 9:07 AM, adam.manzanares@wdc.com wrote:
>>>> From: Adam Manzanares <adam.manzanares@wdc.com>
>>>>
>>>> In order to avoid kiocb bloat for per command iopriority support, rw_hint
>>>> is converted from enum to a u16. Added a guard around ki_hint assignment.
>>>>
>>>> Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>> ---
>>>>   include/linux/fs.h | 13 +++++++++++--
>>>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>>>> index 7f07977bdfd7..50de40dbbb85 100644
>>>> --- a/include/linux/fs.h
>>>> +++ b/include/linux/fs.h
>>>> @@ -284,6 +284,8 @@ enum rw_hint {
>>>>   	WRITE_LIFE_EXTREME	= RWH_WRITE_LIFE_EXTREME,
>>>>   };
>>>>   
>>>> +#define MAX_KI_HINT		((1 << 16) - 1) /* ki_hint type is u16 */
>>>
>>> Instead of having to do this and now rely on those now being synced,
>>> how about something like the below.
>>>
>>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>>> index 760d8da1b6c7..070438d0b62d 100644
>>> --- a/include/linux/fs.h
>>> +++ b/include/linux/fs.h
>>> @@ -299,7 +299,7 @@ struct kiocb {
>>>   	void (*ki_complete)(struct kiocb *iocb, long ret, long ret2);
>>>   	void			*private;
>>>   	int			ki_flags;
>>> -	enum rw_hint		ki_hint;
>>> +	u16			ki_hint;
>>>   } __randomize_layout;
>>>   
>>>   static inline bool is_sync_kiocb(struct kiocb *kiocb)
>>> @@ -1927,12 +1927,22 @@ static inline enum rw_hint file_write_hint(struct file *file)
>>>   
>>>   static inline int iocb_flags(struct file *file);
>>>   
>>> +static inline u16 ki_hint_validate(enum rw_hint hint)
>>> +{
>>> +	typeof(((struct kiocb *)0)->ki_hint) max_hint = -1;
>>
>> This looks complex to me. Would force a reader to lookback at what
>> datatype ki_hint is. I'd prefer to declare it as u16 max_hint = -1, or
>> even the previous #define MAX_KI_HINT format is easier to read. Just a
>> program reading style you are comfortable with though.
> 
> How is it complex? It's defining a type that'll be the same as ki_hint
> in the kiocb, which is _exactly_ what we care about. Any sort of other
> definition will rely on those two locations now being synced. The
> above will never break.
> 
> So I strongly disagree. The above will _never_ require the reader to
> figure out what the type is. Any other variant will _always_ require
> the reader to check if they are the same.
> 

I do think the previous code was a bit easier to parse at first glance, 
but that is outweighed by the fact that the validate function is now 
directly tied to the kiocb ki_hint type.

I also missed one spot where I should have used ki_hint_validate. Will 
resend soon.
