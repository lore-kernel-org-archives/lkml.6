Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753483AbeBVKZw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 05:25:52 -0500
Received: from mail-bn3nam01on0052.outbound.protection.outlook.com ([104.47.33.52]:54240
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753189AbeBVKZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 05:25:50 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 03/20] lightnvm: fix capabilities for 2.0 sysfs
Thread-Topic: [PATCH 03/20] lightnvm: fix capabilities for 2.0 sysfs
Thread-Index: AQHTqvYqUX4YQRQApUG/o9ZTj4y0DKOwB5CAgAAFSwCAAB8xAIAADQl2
Date: Thu, 22 Feb 2018 10:25:47 +0000
Message-ID: <A949EA48-27DF-4370-B213-3A4CE4E4F7D1@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
 <1519205218-26994-4-git-send-email-javier@cnexlabs.com>
 <23b494fb-264d-a8ef-6172-5330d5a63bea@lightnvm.io>
 <19BA9139-DB6D-4A9B-A0B4-72F38BE648E9@cnexlabs.com>,<616ad3c9-b10c-0439-2d63-5e9e25abce84@lightnvm.io>
In-Reply-To: <616ad3c9-b10c-0439-2d63-5e9e25abce84@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-originating-ip: [193.106.164.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR06MB3555;7:Ljz9EuiR/BPXzuo/r0sOTk2TbunqkYgxoBF12ytb4O5xYkFv+1RQYbQaG90sdQU6pTs7ZBiKKAbE74Wuy0Tq4QvjCoRSbckLq4oQxbZJTECpFrtTF73NmEeCGpcWS+bcgcePJzkpcMWaFukFZ1DlKTHugg+3LPy/BvtV52odYncZsvnpRmEyOZxXWRvkJgrDQSmdwtJl59DlegpR9fspHgi7SDRs5yby4VAwXwKI+9I7MNqeUl/T47gwsHLb2DoM
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 01f71ec6-8bdf-44f7-0739-08d579dea35f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:BN6PR06MB3555;
x-ms-traffictypediagnostic: BN6PR06MB3555:
x-microsoft-antispam-prvs: <BN6PR06MB35551A34645BF0C533A42E31BACD0@BN6PR06MB3555.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001078)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231101)(944501161)(10201501046)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR06MB3555;BCL:0;PCL:0;RULEID:;SRVR:BN6PR06MB3555;
x-forefront-prvs: 059185FE08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(376002)(346002)(39840400004)(366004)(189003)(199004)(52314003)(3280700002)(6512007)(5660300001)(2900100001)(6436002)(106356001)(305945005)(54906003)(2906002)(316002)(36756003)(76176011)(68736007)(478600001)(186003)(6916009)(77096007)(6506007)(53546011)(6486002)(3660700001)(26005)(25786009)(102836004)(2950100002)(82746002)(4326008)(81166006)(93886005)(3846002)(105586002)(8676002)(6116002)(14454004)(8936002)(53936002)(33656002)(81156014)(6246003)(86362001)(99286004)(66066001)(7736002)(83716003)(97736004)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR06MB3555;H:BN6PR06MB2626.namprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: oXbDrr+CYzn6BDrDsO+G560unrH0Sln45mJc/Is+eq3Uoyy5dlaymlkG4uEEfSG/Lt7lRkaizEMEdzkOZexcn+ndlmRaG+gdfcuAv9FZd29OptlgFXACuB7EzgfxgyisDH/3fYpM9FaIkPXQApgV15QW4Z6MVOS9KSrB6yEx7Bc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f71ec6-8bdf-44f7-0739-08d579dea35f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2018 10:25:47.1376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3555
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1MAPwvG006532



> On 22 Feb 2018, at 10.39, Matias Bjørling <mb@lightnvm.io> wrote:
> 
> On 02/22/2018 08:47 AM, Javier Gonzalez wrote:
>>> On 22 Feb 2018, at 08.28, Matias Bjørling <mb@lightnvm.io> wrote:
>>> 
>>>> On 02/21/2018 10:26 AM, Javier González wrote:
>>>> Both 1.2 and 2.0 specs define a field for media and controller
>>>> capabilities. Also, 1.2 defines a separate field dedicated to device
>>>> capabilities.
>>>> In 2.0 sysfs, this values have been mixed. Revert them to the right
>>>> value.
>>>> Signed-off-by: Javier González <javier@cnexlabs.com>
>>>> ---
>>>>  drivers/nvme/host/lightnvm.c | 18 +++++++++---------
>>>>  1 file changed, 9 insertions(+), 9 deletions(-)
>>>> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
>>>> index 969bb874850c..598abba66f52 100644
>>>> --- a/drivers/nvme/host/lightnvm.c
>>>> +++ b/drivers/nvme/host/lightnvm.c
>>>> @@ -914,8 +914,8 @@ static ssize_t nvm_dev_attr_show(struct device *dev,
>>>>        if (strcmp(attr->name, "version") == 0) {
>>>>          return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->ver_id);
>>>> -    } else if (strcmp(attr->name, "capabilities") == 0) {
>>>> -        return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.cap);
>>>> +    } else if (strcmp(attr->name, "media_capabilities") == 0) {
>>>> +        return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.mccap);
>>>>      } else if (strcmp(attr->name, "read_typ") == 0) {
>>>>          return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.trdt);
>>>>      } else if (strcmp(attr->name, "read_max") == 0) {
>>>> @@ -993,8 +993,8 @@ static ssize_t nvm_dev_attr_show_12(struct device *dev,
>>>>          return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.tbem);
>>>>      } else if (strcmp(attr->name, "multiplane_modes") == 0) {
>>>>          return scnprintf(page, PAGE_SIZE, "0x%08x\n", dev_geo->c.mpos);
>>>> -    } else if (strcmp(attr->name, "media_capabilities") == 0) {
>>>> -        return scnprintf(page, PAGE_SIZE, "0x%08x\n", dev_geo->c.mccap);
>>>> +    } else if (strcmp(attr->name, "capabilities") == 0) {
>>>> +        return scnprintf(page, PAGE_SIZE, "0x%08x\n", dev_geo->c.cap);
>>>>      } else if (strcmp(attr->name, "max_phys_secs") == 0) {
>>>>          return scnprintf(page, PAGE_SIZE, "%u\n", NVM_MAX_VLBA);
>>>>      } else {
>>>> @@ -1055,7 +1055,7 @@ static ssize_t nvm_dev_attr_show_20(struct device *dev,
>>>>    /* general attributes */
>>>>  static NVM_DEV_ATTR_RO(version);
>>>> -static NVM_DEV_ATTR_RO(capabilities);
>>>> +static NVM_DEV_ATTR_RO(media_capabilities);
>>>>    static NVM_DEV_ATTR_RO(read_typ);
>>>>  static NVM_DEV_ATTR_RO(read_max);
>>>> @@ -1080,12 +1080,12 @@ static NVM_DEV_ATTR_12_RO(prog_max);
>>>>  static NVM_DEV_ATTR_12_RO(erase_typ);
>>>>  static NVM_DEV_ATTR_12_RO(erase_max);
>>>>  static NVM_DEV_ATTR_12_RO(multiplane_modes);
>>>> -static NVM_DEV_ATTR_12_RO(media_capabilities);
>>>> +static NVM_DEV_ATTR_12_RO(capabilities);
>>>>  static NVM_DEV_ATTR_12_RO(max_phys_secs);
>>>>    static struct attribute *nvm_dev_attrs_12[] = {
>>>>      &dev_attr_version.attr,
>>>> -    &dev_attr_capabilities.attr,
>>>> +    &dev_attr_media_capabilities.attr,
>>>>        &dev_attr_vendor_opcode.attr,
>>>>      &dev_attr_device_mode.attr,
>>>> @@ -1108,7 +1108,7 @@ static struct attribute *nvm_dev_attrs_12[] = {
>>>>      &dev_attr_erase_typ.attr,
>>>>      &dev_attr_erase_max.attr,
>>>>      &dev_attr_multiplane_modes.attr,
>>>> -    &dev_attr_media_capabilities.attr,
>>>> +    &dev_attr_capabilities.attr,
>>>>      &dev_attr_max_phys_secs.attr,
>>>>        NULL,
>>>> @@ -1134,7 +1134,7 @@ static NVM_DEV_ATTR_20_RO(reset_max);
>>>>    static struct attribute *nvm_dev_attrs_20[] = {
>>>>      &dev_attr_version.attr,
>>>> -    &dev_attr_capabilities.attr,
>>>> +    &dev_attr_media_capabilities.attr,
>>>>        &dev_attr_groups.attr,
>>>>      &dev_attr_punits.attr,
>>> 
>>> With the mccap changes, it should make sense to keep the capabilities
>>> as is.
>> The change adds mccap, but sysfs points to cap, which is wrong. This
>> patch is needed. Otherwise, we change the name of mccap to cap, which
>> is _very_ confusing to people familiar to both specs. We can change
>> the name of mccap to cap in a future spec revision.
>> Javier
> 
> Think of the sysfs capabilities as an abstract value that defines generic capabilities. It is not directly tied to either 1.2 or 2.0.

I’m thinking about the user looking at sysfs and at the spec at the same time - I myself get confused when names don’t match. 

Anyway, I’ll keep it the way it was and add a comment for clarification. Would that work for you?

Javier 
