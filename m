Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752198AbeEVPn6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:43:58 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28086 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbeEVPnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:43:55 -0400
X-IronPort-AV: E=Sophos;i="5.49,430,1520870400";
   d="scan'208";a="78570445"
From: Adam Manzanares <Adam.Manzanares@wdc.com>
To: Jens Axboe <axboe@kernel.dk>,
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
        "rgoldwyn@suse.com" <rgoldwyn@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "hch@infradread.org" <hch@infradread.org>,
        "jmoyer@redhat.com" <jmoyer@redhat.com>
Subject: Re: [PATCH v6 2/5] fs: Convert kiocb rw_hint from enum to u16
Thread-Topic: [PATCH v6 2/5] fs: Convert kiocb rw_hint from enum to u16
Thread-Index: AQHT8d6qqRDQDKdV5U2KRWEM4J9p4qQ74G4AgAADLQA=
Date: Tue, 22 May 2018 15:43:51 +0000
Message-ID: <8b685910-9dfc-b0d0-769f-f5fc482a3252@wdc.com>
References: <20180522150737.9893-1-adam.manzanares@wdc.com>
 <20180522150737.9893-3-adam.manzanares@wdc.com>
 <11fb2ee5-8352-2d35-3154-68637d99b096@kernel.dk>
In-Reply-To: <11fb2ee5-8352-2d35-3154-68637d99b096@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Adam.Manzanares@wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR04MB0893;7:d6WPrL1tEXcu/sB3uZL+qEHDT//hgj76rgNFiCfGy2jqk3iIeZTXG7DscVJLwJ3HOAHCtQKqgxhadVA1t0KMsFn7av12rfN5qd0TL8+/o/s2xxC1b3PhTPT1Wlx++Xq5u03ZJvrx9VF6dd0Ni3W8bp2Ch6hH8xvZjRhVNU9tbvD6t++dpJNsTGGqmKnWSv6JNK7smQEDxyO8FBpLMZuL5oaH0t5K2N5+UhkCjEQPHGHzPk+anH6PKmtWgydUWdn/;20:l8FP0rGIn9wWG+FZh07nLalhgI0tCImiD2thX6XzZ81tzAst5i+xgImyOr1ylom7Jx12VMLdKmiClgzPOD/X3xd4oQQvxwiJEt+DLsPTv+IalioOu38KQjVvdgGk3DXiF8tSTU/sVQ3q0peiEWIjw8Hq+TuAUByGVtrLOE7JEpA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM5PR04MB0893;
x-ms-traffictypediagnostic: DM5PR04MB0893:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM5PR04MB08934620F8F0C14371B0AE03F0940@DM5PR04MB0893.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR04MB0893;BCL:0;PCL:0;RULEID:;SRVR:DM5PR04MB0893;
x-forefront-prvs: 0680FADD48
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(366004)(39380400002)(396003)(189003)(199004)(99286004)(6436002)(2201001)(6486002)(229853002)(31696002)(7416002)(81156014)(8676002)(81166006)(8936002)(305945005)(59450400001)(4326008)(6246003)(7736002)(3280700002)(72206003)(68736007)(2906002)(36756003)(3660700001)(6116002)(5250100002)(316002)(76176011)(3846002)(5660300001)(2501003)(86362001)(575784001)(66066001)(54906003)(110136005)(53546011)(106356001)(2900100001)(97736004)(14454004)(486006)(53936002)(186003)(102836004)(105586002)(25786009)(31686004)(476003)(26005)(2616005)(6506007)(446003)(478600001)(6512007)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR04MB0893;H:DM5PR04MB0282.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: qblUsNebMi5PcIgSXE8RpEUxM0xuJ0m7JdTwDua0O+FD3pzhOaq67LA6A/ySZR8JpWW6bmXtlBGbHAhIeYeTxUb/LqV7m3JH6d26bCS09txi7AZI9lWnI8pOvIc5VmXrAt994pT1prukJWGnTRYyj/VfF0HPVxUzta3cvb0UCApKp9LJOBYvzMXA9ImJUVZj
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB44D661A4E4E941A45540D624793234@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5ba531a6-10b6-49e4-ca98-08d5bffad103
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba531a6-10b6-49e4-ca98-08d5bffad103
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2018 15:43:51.0747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0893
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4MFi5cH011994



On 5/22/18 8:32 AM, Jens Axboe wrote:
> On 5/22/18 9:07 AM, adam.manzanares@wdc.com wrote:
>> From: Adam Manzanares <adam.manzanares@wdc.com>
>>
>> In order to avoid kiocb bloat for per command iopriority support, rw_hint
>> is converted from enum to a u16. Added a guard around ki_hint assignment.
>>
>> Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   include/linux/fs.h | 13 +++++++++++--
>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 7f07977bdfd7..50de40dbbb85 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -284,6 +284,8 @@ enum rw_hint {
>>   	WRITE_LIFE_EXTREME	= RWH_WRITE_LIFE_EXTREME,
>>   };
>>   
>> +#define MAX_KI_HINT		((1 << 16) - 1) /* ki_hint type is u16 */
> 
> Instead of having to do this and now rely on those now being synced,
> how about something like the below.
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 760d8da1b6c7..070438d0b62d 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -299,7 +299,7 @@ struct kiocb {
>   	void (*ki_complete)(struct kiocb *iocb, long ret, long ret2);
>   	void			*private;
>   	int			ki_flags;
> -	enum rw_hint		ki_hint;
> +	u16			ki_hint;
>   } __randomize_layout;
>   
>   static inline bool is_sync_kiocb(struct kiocb *kiocb)
> @@ -1927,12 +1927,22 @@ static inline enum rw_hint file_write_hint(struct file *file)
>   
>   static inline int iocb_flags(struct file *file);
>   
> +static inline u16 ki_hint_validate(enum rw_hint hint)
> +{
> +	typeof(((struct kiocb *)0)->ki_hint) max_hint = -1;
> +
> +	if (hint <= max_hint)
> +		return hint;
> +
> +	return 0;
> +}
> +
>   static inline void init_sync_kiocb(struct kiocb *kiocb, struct file *filp)
>   {
>   	*kiocb = (struct kiocb) {
>   		.ki_filp = filp,
>   		.ki_flags = iocb_flags(filp),
> -		.ki_hint = file_write_hint(filp),
> +		.ki_hint = ki_hint_validate(file_write_hint(filp)),
>   	};
>   }

Looks good. I'll resubmit.

>   
> 
