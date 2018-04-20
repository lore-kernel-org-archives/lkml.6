Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754895AbeDTNFV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:05:21 -0400
Received: from mail-sn1nam01on0078.outbound.protection.outlook.com ([104.47.32.78]:42330
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754769AbeDTNFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:05:19 -0400
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH] x86/MCE, EDAC/mce_amd: Save all aux registers on SMCA
 systems
Thread-Topic: [PATCH] x86/MCE, EDAC/mce_amd: Save all aux registers on SMCA
 systems
Thread-Index: AQHTyrzRqCN7fg42eUKg23bN8kMvXKQFS3EAgAAGZOCAAYnqgIAC2dNg
Date: Fri, 20 Apr 2018 13:05:17 +0000
Message-ID: <CY4PR12MB155779EEC2894B501F30292EF8B40@CY4PR12MB1557.namprd12.prod.outlook.com>
References: <20180402195707.42875-1-Yazen.Ghannam@amd.com>
 <20180417172102.GA3633@pd.tnic>
 <CY4PR12MB15574493593120818D9BFE11F8B70@CY4PR12MB1557.namprd12.prod.outlook.com>
 <20180418171347.GH4795@pd.tnic>
In-Reply-To: <20180418171347.GH4795@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR12MB1413;7:Ny34XD/2e6fta/giYdSvz0zRVqBJcXjwU5IiG7H/gobMxujNNOl48wCINf/jTdvT6U7yIVWit2bJKgf0Wkaen4yomDSpg+F6oJXa4W2c3vGPX/VuOEvwVxuMW9pel23VTdLBjqElcsKjRriSJ05VVETA+hzc69VX4kOm21VcOuuv3RbpdM8CNzYMxFhyUu5kQ7E6ky1uvp1+Oq9L8IkwsM/x65umPgJWc4HWiwkcctKBF9DXBN+RDNsl+G7vM/2F;20:cjfuNV3THyMLA8ZZ+Prh+7fCdH+J7mq+a6tyvilY73m/InK6XKZhFLeZk9AMtd91pr4VldYWwp3txZcrVFn2hlIKRtREkBJ0x7trl/2PQ6Yl1cB5dRJM631mGjtitQ2sjhufdyime9o1IbiJIsOHWf94hg6jYmt3pB/ODS/B84/ySRVm8R30inVxp2xbAwaGQmmAdP5b7JsPQHN6WhLNG9qN3gAi9heXZIJ3zgHe55zhxn9PegA5AN7LyaMNZiOP
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1413;
x-ms-traffictypediagnostic: CY4PR12MB1413:
x-microsoft-antispam-prvs: <CY4PR12MB1413AF2C3B6B28C99044CCD1F8B40@CY4PR12MB1413.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501394)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:CY4PR12MB1413;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1413;
x-forefront-prvs: 0648FCFFA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(39380400002)(39860400002)(376002)(13464003)(66066001)(3280700002)(6246003)(25786009)(6116002)(53936002)(3846002)(5250100002)(33656002)(229853002)(93886005)(3660700001)(2906002)(11346002)(6916009)(26005)(2900100001)(86362001)(316002)(476003)(186003)(446003)(4326008)(54906003)(55016002)(7736002)(59450400001)(5660300001)(8936002)(76176011)(8676002)(6436002)(102836004)(53546011)(72206003)(6506007)(7696005)(305945005)(478600001)(9686003)(81166006)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1413;H:CY4PR12MB1557.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: 6fyZ5+wljIYede1cKzqWr9VQ/wGnEo8CNaYP2pc+3GgZY0mJSo2vegk1Hn/MwoTz42/aHcjBPnrLiclMw29HWHuVqD5exG+Cpm879IILUVOM1SEU2lBdbcZZcaYInYHa4V+WUwC6yfzaI5tJ3h34Dzi2lKPI0TLW0CUWpoWiEUj1ntGZuiXHd/fgJQcI3zuB
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5844cae3-16b8-40c2-9324-08d5a6bf5d55
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5844cae3-16b8-40c2-9324-08d5a6bf5d55
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2018 13:05:17.6084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1413
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3KD5QqC024457

> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Wednesday, April 18, 2018 1:14 PM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org;
> tony.luck@intel.com; x86@kernel.org
> Subject: Re: [PATCH] x86/MCE, EDAC/mce_amd: Save all aux registers on
> SMCA systems
> 
> On Tue, Apr 17, 2018 at 06:30:34PM +0000, Ghannam, Yazen wrote:
> > We could but it's an issue of documentation and testing the older systems.
> >
> > My first pass at this was to unconditionally read the registers because my
> > understanding was that registers that aren't accessible would be read-as-
> zero.
> > I thought this was a common MCA implementation. But Tony pointed out
> that
> > this isn't the case on Intel systems. This is the case on recent AMD systems.
> But
> > I don't know if it's the case on older systems which may or may not have
> > followed the Intel implementation more closely.
> 
> So if our worry is the #GPs, we can always use the rdmsr*_safe()
> variants and look at the return value. And dump a invalid value like
> 0xdeadbeef or so, if the read failed.
> 
> But if any bit of info we've gotten this way, helps us debug an MCE,
> we're already golden!
> 

Okay, I can do that. What about using mce_rdmsrl()? The value gets set to
0 and a user gets a single warning. This may be more clear to the user. Also,
it shouldn't affect code that checks for non-zero values, like in __print_mce().

> > For example,
> >
> > Deferred error occurs:
> > - MCA_{STATUS,ADDR,DESTAT,DEADDR} all have valid data.
> >
> > MCE occurs
> > - MCA_{STATUS,ADDR} are overwritten with non-zero data.
> > - MCE handler clears MCA_STATUS. MCA_ADDR is non-zero.
> >
> > DFR handler finds MCA_STATUS[Deferred] is clear, so it saves
> > MCA_DESTAT and MCA_DEADDR which is 0.
> >
> > If !m->addr (which has MCA_DEADDR), then we read MCA_STATUS
> > which has the address from the MCE.
> 
> The code could use a shorter version of this as a comment to state why
> we're doing it. Because it is not obvious.
> 

Yes, will do.

Thanks,
Yazen
