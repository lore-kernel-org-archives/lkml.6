Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032736AbeBNQii (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:38:38 -0500
Received: from mail-by2nam03on0067.outbound.protection.outlook.com ([104.47.42.67]:54211
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032526AbeBNQig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:38:36 -0500
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>, "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 1/3] x86/MCE/AMD: Redo function to get SMCA bank type
Thread-Topic: [PATCH 1/3] x86/MCE/AMD: Redo function to get SMCA bank type
Thread-Index: AQHTm41bcw4ycYHHg0+1EhCRujD/g6OapSaAgAmFcnA=
Date: Wed, 14 Feb 2018 16:38:34 +0000
Message-ID: <DM5PR12MB1916E752AF9164228359BC9EF8F50@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180201184813.82253-1-Yazen.Ghannam@amd.com>
 <20180208150433.GD7964@pd.tnic>
In-Reply-To: <20180208150433.GD7964@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [71.199.237.95]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1705;7:AHwwPq+SapSzT1Qbz5OeSqh3WpoKtOD9Ze2MrGnGtKp/qCD39901c+AObAybtZnlFB9WWqYhYSjtz10EyO2XXurU+XKosCnq5ucgixng7a+967U2ASRj1HzcwoQVJPgZsV6Nusr2uJVoAJjyBq7REqmCeUGZZQOXH9/8nm2GQCfT503PNK/RtwYn+QQqDQ4SNOVT9dY3xwxWAy/fqQBw4t8oGJqZ2etoIFcFc3pJIzFYTvL0I+VvlwstpZkDAp8y;20:E1nuiv1pOWjf9SaXmWpTZk8hlFj1Zyw6xHu/SQSO0gMxBZB6hsAuGZErU/X3WmlaaBOzhB8FKNLt98z5HDxd5Dn75qgOqRWPTR1iJ3n7NW7AFDn1KMBFkhacDRN6CMPT0/WHlGY+0tXENXK8kG0aqGKhKFuF4+T6KzH7eP7ie3k8Cz2kEUbNaCboaWSZR7UWD8XIMJreiMoQENk9/7/3Pq1HOk+6JvUhkJUlR7MBkj4QEJfZEoqS1VqicU+vXTb6
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: daa9ef2d-4da1-4fda-78e4-08d573c9642f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB1705;
x-ms-traffictypediagnostic: DM5PR12MB1705:
x-microsoft-antispam-prvs: <DM5PR12MB17057FD97D0429C6D4D88A2AF8F50@DM5PR12MB1705.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR12MB1705;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1705;
x-forefront-prvs: 0583A86C08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(13464003)(199004)(189003)(25786009)(81166006)(15650500001)(6436002)(72206003)(99286004)(33656002)(86362001)(76176011)(3660700001)(3280700002)(14454004)(68736007)(7696005)(6506007)(478600001)(2900100001)(26005)(4326008)(77096007)(105586002)(102836004)(53546011)(229853002)(66066001)(106356001)(9686003)(54906003)(316002)(53936002)(7736002)(305945005)(74316002)(186003)(3846002)(8936002)(97736004)(55016002)(8676002)(2950100002)(2906002)(6246003)(5660300001)(6916009)(81156014)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1705;H:DM5PR12MB1916.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: hZiHclwJztpoXwZEl9k2rTrQnzAzMjKAAYhHxOGsK8291QHVpGyksb0YBCs7cqIZP56d3kjW5rXlAlinrHc/Ow==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daa9ef2d-4da1-4fda-78e4-08d573c9642f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2018 16:38:34.7996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1705
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1EGcgSS003960

> -----Original Message-----
> From: Borislav Petkov [mailto:bp@alien8.de]
> Sent: Thursday, February 8, 2018 10:05 AM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org; bp@suse.de;
> tony.luck@intel.com; x86@kernel.org
> Subject: Re: [PATCH 1/3] x86/MCE/AMD: Redo function to get SMCA bank type
> 
> On Thu, Feb 01, 2018 at 12:48:11PM -0600, Yazen Ghannam wrote:
> >  arch/x86/kernel/cpu/mcheck/mce_amd.c | 15 +++++++--------
> >  1 file changed, 7 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c
> b/arch/x86/kernel/cpu/mcheck/mce_amd.c
> > index 0f32ad242324..4e16afc0794d 100644
> > --- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
> > +++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
> > @@ -110,14 +110,14 @@ const char *smca_get_long_name(enum
> smca_bank_types t)
> >  }
> >  EXPORT_SYMBOL_GPL(smca_get_long_name);
> >
> > -static enum smca_bank_types smca_get_bank_type(struct mce *m)
> > +static enum smca_bank_types smca_get_bank_type(unsigned int bank)
> >  {
> >  	struct smca_bank *b;
> >
> > -	if (m->bank >= N_SMCA_BANK_TYPES)
> > +	if (bank >= ARRAY_SIZE(smca_banks))
> 
> MAX_NR_BANKS
> 

I know that we're declaring smca_banks[] to have MAX_NR_BANKS items. But
shouldn't we directly check that an index is within the bounds of the array?
We'll have a bug if we check against MAX_NR_BANKS and the definition of
smca_banks[] changes.

Thanks,
Yazen
