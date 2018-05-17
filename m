Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbeEQOFn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 10:05:43 -0400
Received: from mail-bl2nam02on0042.outbound.protection.outlook.com ([104.47.38.42]:27072
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751468AbeEQOFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 10:05:41 -0400
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Borislav Petkov <bp@suse.de>
CC: Johannes Hirte <johannes.hirte@datenkhaos.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 3/3] x86/MCE/AMD: Get address from already initialized
 block
Thread-Topic: [PATCH 3/3] x86/MCE/AMD: Get address from already initialized
 block
Thread-Index: AQHTm41cR37jOK/olE2Igoi/oKD/9qP/29aAgAPg84CAAaZJUIArxy4AgAJuKICAAIbngIAAQMoAgAAhoBCAABF2gIAAAs6g
Date: Thu, 17 May 2018 14:05:39 +0000
Message-ID: <CY4PR12MB1557F564AF25A4F2306C7DE4F8910@CY4PR12MB1557.namprd12.prod.outlook.com>
References: <20180201184813.82253-1-Yazen.Ghannam@amd.com>
 <20180201184813.82253-3-Yazen.Ghannam@amd.com>
 <20180414004230.GA2033@probook> <20180416115624.GA1543@probook>
 <CY4PR12MB1557FB8EB5C17E55A9B405D8F8B70@CY4PR12MB1557.namprd12.prod.outlook.com>
 <20180515093953.GA1746@probook> <20180516224641.GA31929@pd.tnic>
 <20180517064930.GA26421@probook> <20180517104124.GA25595@pd.tnic>
 <CY4PR12MB1557AB31F5F9D1ECBDAC2DA6F8910@CY4PR12MB1557.namprd12.prod.outlook.com>
 <20180517134415.GC27738@pd.tnic>
In-Reply-To: <20180517134415.GC27738@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [2601:345:301:c593:3414:3059:320b:d027]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR12MB1240;7:o0NvJ7qmPKBLFRbZDQbw+ZdZNdADnBni9yhGmxeQjH2FzOibNPapd7JeHBzEiThPTMm5jnxukwQXYlM0D31Kf6D4kWyZzXUSHw2e6wEeomz5K9yjHwI5OXHbRey+x9LW2spBYh/6f1/hJXR3z61wrodud3tLj6baH9J2vNRN9yDXhnYxu1EMbKdkj5NE23pjfCowsmZMWAmcZxsUrZFTe1xnmBQxsmRFvCjj6qAHg7F97dQjTd/2o5DLAeBbVoFr;20:NXMgnEj4fqZPCM0lQLxTsCkBD1VA6i7d5m+c0E5ziLgf44bJqNIpouEuoI//ymxBnQ1SUQqEsZig+qde3/RGd1sixHJOkVfMGq8+5ZA4vcd91j0tGvGylIQfdpndWtzjJrIb6p51dOOuA9bB7v8NWVgZeXtO6KsNlKmxe19W3VfvcbY4E99FDf//HnNAXcAtjsfBdsaMcPAWfolsdiAAqulLtGc1acYVuL7m7nBg+nA4uP22o9o8J7nWjfJjnq/A
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1240;
x-ms-traffictypediagnostic: CY4PR12MB1240:
x-microsoft-antispam-prvs: <CY4PR12MB1240D3C7273D25D36F9F27FDF8910@CY4PR12MB1240.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CY4PR12MB1240;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1240;
x-forefront-prvs: 067553F396
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(376002)(396003)(346002)(366004)(13464003)(199004)(189003)(25786009)(7696005)(59450400001)(2906002)(86362001)(99286004)(5660300001)(186003)(4326008)(446003)(76176011)(53546011)(3280700002)(72206003)(97736004)(316002)(102836004)(486006)(54906003)(476003)(93886005)(6506007)(5250100002)(3660700001)(14454004)(11346002)(478600001)(74316002)(6916009)(9686003)(305945005)(8676002)(6246003)(6436002)(46003)(106356001)(81156014)(81166006)(7736002)(6116002)(53936002)(68736007)(33656002)(55016002)(2900100001)(229853002)(105586002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1240;H:CY4PR12MB1557.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: QWqbSdLkkMTgwswTSrqj9RsQIDSOCZ2UWW75boU6xm/l6y4wslLYqoilVQgj0ZElATV/OnUjoxmrvHYfQKvl+1SEadF9/I9+0KKMwNCSYQn6t1FjCIvPJG4rZOuUnWBGv2tjM82iUA0uC8xTdvO9vFj9LVTJ9j0mFqSk4pd93daMM0XmpsE2lfxrpOb8RZe8
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 3673e957-8b55-4c66-eef7-08d5bbff4513
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3673e957-8b55-4c66-eef7-08d5bbff4513
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2018 14:05:39.1219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1240
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4HE5mAA015051

> -----Original Message-----
> From: Borislav Petkov <bp@suse.de>
> Sent: Thursday, May 17, 2018 9:44 AM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: Johannes Hirte <johannes.hirte@datenkhaos.de>; linux-
> edac@vger.kernel.org; linux-kernel@vger.kernel.org; tony.luck@intel.com;
> x86@kernel.org
> Subject: Re: [PATCH 3/3] x86/MCE/AMD: Get address from already initialized
> block
> 
> On Thu, May 17, 2018 at 01:04:19PM +0000, Ghannam, Yazen wrote:
...
> 
> I check PFEH is enabled how?
> 

If MISC0 is RAZ then you can assume PFEH is enabled. There should be a BIOS
option to disable it.

BTW, I just tried you patch with PFEH disabled and it seems to work fine.

...
> > Since we're caching the values during init, we can drop all the
> > *_on_cpu() calls. What do you think?
> 
> Well, if they're all the same on all CPUs, sure. That's your call.
> 

Let's drop them. We won't need them since we're caching the values during
init. And the init code is run on the target CPU.

We can just make smca_bank_addrs[][] into per_cpu when we need to support
different values on different CPUs.

Thanks,
Yazen
